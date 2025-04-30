defmodule Ralsei.Command.Yugioh do

  def handleYugiohCommand(content) do
    content |> validateYugiohCommand() |> generateYugiohResponse()
  end

  def validateYugiohCommand(content) do
    command = String.split(content, " ")
    case command do
      ["!yugioh" | cardName] ->
        response = HTTPoison.get("https://db.ygoprodeck.com/api/v7/cardinfo.php?name=#{URI.encode(Enum.join(cardName," "))}")
        case response do
          {:ok, value} ->
            json = JSON.decode(value.body)
            case json do
              {:ok, map} -> card = map["data"] |> List.first()
              cardImage = card["card_images"] |> List.first()
                {:ok, "Nome: #{card["name"]}\n
                Tipo: #{card["type"]}\n
                Efeito(s): #{card["desc"]}\n
                ataque: #{card["atk"]}\n
                defesa: #{card["def"]}\n
                nivel: #{card["level"]}\n
                #{cardImage["image_url"]}"}

                _ ->
                  :error
            end
          _ ->
            :error
        end
      _ -> :error
    end
  end

  def generateYugiohResponse({:ok, value}) do
    value
  end

  def generateYugiohResponse(:error) do
    "Esse card não existe"
  end
end
