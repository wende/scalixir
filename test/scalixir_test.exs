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

  test "Works as a compiler" do
    File.rm_rf!(".sex/")
    Mix.Task.run "compile.scalixir", ["examples"]
    assert File.read!(".sex/sex/1.ex") == File.read!("examples/1.ex")
  end
end
