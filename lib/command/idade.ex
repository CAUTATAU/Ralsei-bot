defmodule Ralsei.Command.Idade do

  def handleIdadeCommand(content) do
    content |> validateIdadeCommand() |> generateIdadeResponse()
  end

  def validateIdadeCommand(content) do
    command = String.split(content, " ")
    case command do
      ["!idade", name] ->
        response = HTTPoison.get(URI.encode("https://api.agify.io/?name=#{name}&country_id=BR"))
        case response do
          {:ok, value} ->
            json = JSON.decode(value.body)
            case json do
              {:ok, map} -> {:ok, "hmmmmm, pelo nome #{map["name"]}, você deve ter #{map["age"]} anos."}
              _ ->
                :error
            end
          _ ->
            :error
        end
      _ -> :error
    end
  end

  def generateIdadeResponse({:ok, value}) do
    value
  end

  def generateIdadeResponse(:error) do
    "Erro"
  end
end
