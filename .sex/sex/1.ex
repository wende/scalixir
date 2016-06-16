defmodule MyModule do
  def somefunction(a, b \\ 10)
  def somefunction(a, b) do
    case b do
      5 -> :ok
      _ -> :not_ok
    end
  end
  def somefunction(a, 5) do
    Enum.map(a, fn b -> b * 5 end)
  end

  defmacro something(a, b) do
    IO.puts "hey"
  end

  defmacrop deffun() do
    quote do
      def yo() do
        :yo
      end
    end
  end

  defp two(), do: 2
end
 
