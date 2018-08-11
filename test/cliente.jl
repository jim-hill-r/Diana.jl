query = """
{
  neomatrix{
    nombre
    linkedin
  }
}
"""

r = Queryclient("https://neomatrix.herokuapp.com/graphql",query,headers=Dict("header"=>"value"))

@test r.Info.status == 200
@test r.Data == "{\"data\":{\"neomatrix\":{\"nombre\":\"Acevedo Maldonado Josue\",\"linkedin\":\"https://www.linkedin.com/in/acevedo-maldonado-josue/\"}}}"


client = GraphQLClient("https://api.graph.cool/simple/v1/movies",auth="Bearer my-jwt-token",headers=Dict("header"=>"value"))

query2 = """
query getMovie(\$title: String!) {
  Movie(title:\$title) {
    releaseDate
    actors {
      name
    }
  }
}
"""
r = client.Query(query2,vars=Dict("title" => "Inception"))

@test r.Info.status == 200
@test r.Data == "{\"data\":{\"Movie\":{\"releaseDate\":\"2010-08-28T20:00:00.000Z\",\"actors\":[{\"name\":\"Leonardo DiCaprio\"},{\"name\":\"Ellen Page\"},{\"name\":\"Tom Hardy\"},{\"name\":\"Joseph Gordon-Levitt\"},{\"name\":\"Marion Cotillard\"}]}}}"

query2 = """
{
  Movie(title: "Inception"){
    actors{
      name
    }
  }
}
"""
r = client.Query(query2)

@test r.Info.status == 200
@test r.Data == "{\"data\":{\"Movie\":{\"actors\":[{\"name\":\"Leonardo DiCaprio\"},{\"name\":\"Ellen Page\"},{\"name\":\"Tom Hardy\"},{\"name\":\"Joseph Gordon-Levitt\"},{\"name\":\"Marion Cotillard\"}]}}}"

@test client.headers(Dict("header"=>"value")) == Dict("header"=>"value")

@test client.serverAuth("Bearer my-jwt-token") == "Bearer my-jwt-token"