defmodule Erlixir.ScalixirTest do
  use ExUnit.Case

  test "translates_scalixir" do
    code =
      "sex/1.sex"
      |> File.read!
      |> ConservativeElixir.Scalixir.parse()
      |> IO.puts
      |> Code.string_to_quoted!

    assert code = File.read!("examples/1.ex")
  end
end
