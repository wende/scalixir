defmodule Mix.Tasks.Compile.Scalixir do
  use Mix.Task
  @ext ".sex"
  @switches

  @spec run(OptionParser.argv) :: :ok | :noop
  def run(args) do
    {opts, _, _} = OptionParser.parse(args)

    project = Mix.Project.config
    dest = Mix.Project.compile_path(project)
    srcs = project[:elixirc_paths]
    skip =
      case Keyword.get_values(opts, :elixirc_paths) do
        [] -> []
        ep -> srcs -- ep
      end

    compile_all(srcs)
  end

  def compile_all(srcs) do
    Mix.Generator.create_directory @ext

    srcs
    |> Mix.Utils.extract_files("*" <> @ext)
    |> Enum.map(&compile_file(&1))
  end

  def compile_file(filename) do
    newfilename = filename |> String.replace(@ext, ".ex")
    newdir =
      newfilename
      |> String.split("/")
      |> Enum.reverse
      |> Kernel.tl
      |> Enum.reverse
      |> Enum.join("/")
    Mix.Generator.create_directory @ext <> "/" <> newdir
    newcode =
      filename
      |> File.read!
      |> process_file
    File.write!(@ext <> "/" <> newfilename, newcode)
  end

  def process_file(content) do
    ConservativeElixir.Scalixir.parse(content)
  end
end
