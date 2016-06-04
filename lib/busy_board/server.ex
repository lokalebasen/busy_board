defmodule BusyBoard.Server do
  use GenServer

  @mod __MODULE__

  def start_link do
    :ets.new :people, [:set, :named_table]
    ~w(Niels Caroline Matt Kasper Jonas)a
      |> Enum.each(fn name -> :ets.insert(:people, {name, :available}) end)

    GenServer.start_link(@mod, :people, name: @mod)
  end

  # Client API

  def all, do: GenServer.call(@mod, :all)

  # OTP callbacks

  def handle_call(:all, _from, table) do
    everyone = :ets.foldr fn name_pair, acc -> acc ++ [name_pair] end, [], table
    {:reply, everyone, table}
  end
end
