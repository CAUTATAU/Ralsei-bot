defmodule Ralsei.Command.Coffee do


  def handleCoffeeCommand(content) do
    content |> validateCoffeeCommand() |> generateCoffeeResponse()
  end

  def validateCoffeeCommand(content) do
    command = String.split(content, " ")
    case command do
      ["!coffee"] ->
        response = HTTPoison.get("https://coffee.alexflipnote.dev/random.json")
        case response do
          {:ok, value} ->
            json = Jason.decode!(value.body)
            {:ok, json["file"]}
          _ ->
            :error
        end
      _ -> :error
    end
  end

  def generateCoffeeResponse({:ok, value}) do
    value
  end

  def generateCoffeeResponse(:error) do
    "Não consegui encontrar uma imagem de café, desculpe!"
  end
end
