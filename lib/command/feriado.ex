defmodule Ralsei.Command.Feriado do

  def handleFeriadoCommand(content) do
    content |> validateFeriadoCommand() |> generateFeriadoResponse()
  end

  def validateFeriadoCommand(content) do
    command = String.split(content, " ")
    case command do
      ["!feriado" | date] ->
        date_str = Enum.join(date, " ")

        response =
          cond do
            date_str == "proximos" or date_str == "proximo" ->
              HTTPoison.get("https://date.nager.at/api/v3/NextPublicHolidays/BR")
            true ->
              HTTPoison.get("https://date.nager.at/api/v3/PublicHolidays/#{date}/BR")
          end


        case response do
          {:ok, value} ->
            json = JSON.decode(value.body)
            case json do
              {:ok, map} ->
                if date_str == "proximo" do
                  holiday = List.first(map)
                  {:ok, "Nome do Feriado: #{holiday["localName"]}\nData: #{holiday["date"]}"}
                else {:ok, Enum.map(map, fn holiday -> "Nome do Feriado: #{holiday["localName"]}\nData: #{holiday["date"]}" end)}
                end

            end
          _ ->
            :error
        end
      _ -> :error
    end
  end

  def generateFeriadoResponse({:ok, value}) when is_list(value) do
    Enum.join(value, "\n\n")
  end

  def generateFeriadoResponse({:ok, value}) do
    value
  end

  def generateFeriadoResponse(:error) do
    "Esse dia não é um feriado"
  end
end
