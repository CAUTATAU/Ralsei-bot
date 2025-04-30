defmodule Ralsei.Command.Pokemon do

  def handlePokemonCommand(content) do
    content |> validadePokemonCommand() |> generatePokemonResponse()
  end

  def validadePokemonCommand(content) do
    command = String.split(content, " ")
    case command do
      ["!pokemon", pokemonName] ->
        response = HTTPoison.get("https://pokeapi.co/api/v2/pokemon-form/#{pokemonName}")
        case response do
          {:ok, value} ->
            json = JSON.decode(value.body)
            case json do

              {:ok, map} -> types = Enum.map(map["types"], fn type -> type["type"]["name"] end)
                {:ok, "nome: #{map["name"]}\ntipo: #{Enum.join(types, ", ")} - #{map["sprites"]["front_default"]}"}
              _ ->
                :error
            end
            _ ->
              :error
        end
      _ -> :error
    end
  end

  def generatePokemonResponse({:ok, value}) do
    value
  end

  def generatePokemonResponse(:error) do
    "Esse pokemon não existe"
  end
end
