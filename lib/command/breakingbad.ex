defmodule Ralsei.Command.Breakingbad do

  def handleBreakingBadCommand(content) do
    content |> validateBreakingBadCommand() |> generateBreakingBadResponse()
  end

  def validateBreakingBadCommand(content) do
    command = String.split(content, " ")
    case command do
      ["!breakingbad"] ->
        response = HTTPoison.get("https://api.breakingbadquotes.xyz/v1/quotes")
        case response do
          {:ok, value} ->
            json = JSON.decode(value.body)
            case json do
              {:ok, map} -> quote = List.first(map)
                {:ok, "Frase: #{quote["quote"]}\nAutor: #{quote["author"]}"}
              _ ->
                :error
            end
          _ ->
            :error
        end
      _ -> :error
    end
  end

  def generateBreakingBadResponse({:ok, value}) do
    value
  end

  def generateBreakingBadResponse(:error) do
    "Não consegui encontrar uma frase de Breaking Bad, desculpe!"
  end
end
