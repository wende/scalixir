defmodule ConservativeElixir do
  def compile_all(srcs) do
    Mix.Generator.create_directory ".rex"

    srcs
    |> Mix.Utils.extract_files("*.rex")
    |> Enum.map(&compile_file(&1))
  end

  def compile_file(filename) do
    newfilename = filename |> String.replace(".rex", ".ex")
    filename
    |> File.read!
    |> process_file
    |> File.write!(".rex/" <> newfilename)
  end

  def process_file(content) do
    Mix.shell.info(content)
  end
end
