defmodule ErlixirTest do
  use ExUnit.Case

  alias ConservativeElixir.Lexer

  test "replaces do_colons" do
    code = Lexer.replace_do_colons ~S"""
    a() -> IO.inspect(:ok)
    """

    verify_code(code)

    assert code == ~S"""
    def a(), do: IO.inspect(:ok)
    """
  end

  test "replaces do_ends" do
    code = Lexer.replace_defs ~S"""
    a() ->
      IO.inspect(:ok)
    """

    verify_code(code)

    assert code == ~S"""
    def a() do
      IO.inspect(:ok)
    end

    """
  end

  test "Replaces function heads" do
    code = Lexer.replace_function_heads ~S"""
    func(a, b \\ [])
    func(a, b, c) ->
    """

    assert code == ~S"""
    def func(a, b \\ [])
    func(a, b, c) ->
    """
  end

  test "replaces whole code" do
    code = Lexer.replace_all ~S"""
    somefunction(a, b \\ 10)
    somefunction(a, b) ->
      case b of
        5 -> :ok
        _ > :not_ok
      end

      2 + 2

    somefunction(a, 5) ->
      Enum.map a, fn b -> b * 5 end

    something(a, b) ->>
      IO.puts "Hey"


    -deffun() ->>
      quote do
        yo() ->
          :yo
      end

    -two() -> 2

    a() ->
      IO.inspect(:ok)

    """
    verify_code(code)
  end

  test "Replaces vars to lowercase"

  test "Minus everything that's not in export if export exists"

  test "defines module"

  defp verify_code(code) do
    case Code.string_to_quoted(code) do
      {:ok, _} -> :ok
      {:error, reason} ->
        IO.puts code
        raise reason
    end
  end
end
