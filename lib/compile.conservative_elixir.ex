defmodule Mix.Tasks.Compile.ConservativeElixir do
  use Mix.Task

  @spec run(OptionParser.argv) :: :ok | :noop
  def run(args) do
    {opts, _, _} = OptionParser.parse(args, switches: @switches)

    project = Mix.Project.config
    dest = Mix.Project.compile_path(project)
    srcs = project[:elixirc_paths]
    skip =
      case Keyword.get_values(opts, :elixirc_paths) do
        [] -> []
        ep -> srcs -- ep
      end

    ConservativeElixir.compile_all(srcs)
  end
end
