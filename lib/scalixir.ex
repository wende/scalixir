defmodule ConservativeElixir.Scalixir do


  def parse(code) do
    code
    |> replace_brackets
    |> replace_tuples
    |> replace_oneliners
  end

  def replace_brackets(string) do
    string
    |> String.replace(~r/\{/, " do")
    |> String.replace(~r/\}/, "end")
  end

  def replace_oneliners(string) do
    string
    |> String.replace(~r/(def\w*\s+[\w?!]+(\(.*?\))?)\s*=/, "\\g{1}, do:")
  end

  def replace_tuples(string) do
    string
    |> String.replace(~r/([^\w])\((.*,.*)\)/, "\\g{1}{\\g{2}}")
  end

end
