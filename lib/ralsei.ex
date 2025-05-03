defmodule Ralsei do

  use Nostrum.Consumer

  alias Nostrum.Api.Message

  alias Ralsei.Command.Coffee
  alias Ralsei.Command.Pokemon
  alias Ralsei.Command.Tmdb
  alias Ralsei.Command.Feriado
  alias Ralsei.Command.Yugioh
  alias Ralsei.Command.Breakingbad
  alias Ralsei.Command.Idade
  @moduledoc """
  Documentation for `Ralsei`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Ralsei.hello()
      :world

  """
  def handle_event({:MESSAGE_CREATE, msg, _ws_state}) do
    cond do
      String.starts_with?(msg.content, "!ola") ->
        Message.create(msg.channel_id, "ola, #{msg.author.username}!")

      String.starts_with?(msg.content, "!coffee") ->
        Message.create(msg.channel_id, Coffee.handleCoffeeCommand(msg.content))

      String.starts_with?(msg.content, "!pokemon") ->
        Message.create(msg.channel_id, Pokemon.handlePokemonCommand(msg.content))

      String.starts_with?(msg.content, "!tmdb") ->
        Message.create(msg.channel_id, Tmdb.handleTmdbCommand(msg.content))

      String.starts_with?(msg.content, "!feriado") ->
        Message.create(msg.channel_id, Feriado.handleFeriadoCommand(msg.content))

      String.starts_with?(msg.content, "!yugioh") ->
        Message.create(msg.channel_id, Yugioh.handleYugiohCommand(msg.content))

      String.starts_with?(msg.content, "!breakingbad") ->
        Message.create(msg.channel_id, Breakingbad.handleBreakingBadCommand(msg.content))

      String.starts_with?(msg.content, "!idade") ->
        Message.create(msg.channel_id, Idade.handleIdadeCommand(msg.content))

      true ->
        :ignore
    end
  end
end
