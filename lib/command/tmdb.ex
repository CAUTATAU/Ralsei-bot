defmodule Ralsei.Command.Tmdb do

  def handleTmdbCommand(content) do
    content |> validateTmdbCommand() |> generateTmdbResponse()
  end

  def validateTmdbCommand(content) do
    headers = [
      {"Authorization", "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwNGJhMjkwNTAyNDkzMGIxYmQ2NWRlNDc1ZDlkYzhjZSIsIm5iZiI6MTczMTM0ODcwNy4wODQsInN1YiI6IjY3MzI0OGUzZWJjNWEyNmU1ZTQ5NzU0ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.xivji7JS6kAfaCuvQi0ThyHURwt1WkqXwWSyMjREwLw"},
      {"Content-Type", "application/json"}
    ]
    command = String.split(content, " ")
    case command do
      ["!tmdb" | movieName] ->
        response = HTTPoison.get("https://api.themoviedb.org/3/search/movie?query=#{URI.encode(Enum.join(movieName," "))}&language=pt-BR&page=1", headers)
        case response do
          {:ok, value} ->
            json = JSON.decode(value.body)
            case json do
              {:ok, map} -> movie =  map["results"] |> List.first()
            {:ok, "Título: #{movie["title"]}\nDescrição: #{movie["overview"]}\nData de Lançamento: #{movie["release_date"]}\nNota: #{movie["vote_average"]}\nLink: https://www.themoviedb.org/movie/#{movie["id"]}"}
          _ ->
            :error
            end
        end
      _ -> :error
    end
  end

  def generateTmdbResponse({:ok, value}) do
    value
  end

  def generateTmdbResponse(:error) do
    "Esse filme não existe"
  end

end
