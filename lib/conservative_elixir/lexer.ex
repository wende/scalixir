defmodule ConservativeElixir.Lexer do

  @def ~r/([\t ]*)([\w!?]+\(.*\) )->((?=\s*\n(\s*)\S.*)(((\4).*|\s)*((\4).*)+))/m
  @defmacro ~r/([\t ]*)([\w!?]+\(.*\) )->>((?=\s*\n(\s*)\S.*)(((\4).*|\s)*((\4).*)+))/m
  @do_colon ~r/(\w+\(.*?\)) *->( \S+.*)/
  @macro_colon ~r/(\w+\(.*?\)) *->>( \S+.*)/
  @empty_line ~r/\s*/
  @indentation ~r/\s+/
  @function_head_def ~r/(\w+)(\(.*?\)\s*$\s*\1)/m
  @privates ~r/-(def\w*)(\s+.*do)/
  @of ~r/\bof\b/

  def replace_all(code) do
    code
    |> replace_function_heads
    |> replace_defs
    |> replace_defmacros
    |> replace_do_colons
    |> replace_macro_colons
    |> replace_privates
    |> replace_of
  end

  def replace_of(string) do
    string
    |> replace_string(@of, "do")
  end

  def replace_privates(string) do
    string
    |> replace_string(@privates, "\\g{1}p\\g{2}")
  end

  def replace_do_colons(string) do
    string
    |> replace_string(@do_colon, "def \\g{1}, do:\\g{2}")
  end
  def replace_macro_colons(string) do
    string
    |> replace_string(@macro_colon, ", do:\\g{1}")
  end

  def replace_defs(string) do
    string
    |> replace_string(@def, "\\g{1}def \\g{2}do\\g{3}\n\\g{1}end\n")
  end
  def replace_defmacros(string) do
    string
    |> replace_string(@defmacro, "\\g{1}defmacro \\g{2}do\\g{3}\n\\g{1}end\n")
  end

  def replace_function_heads(string) do
    string
    |> replace_string(@function_head_def, "def \\g{0}")
  end

  defp replace_string(string, regex, replacer) do
    Regex.replace(regex, string, replacer)
  end

end
