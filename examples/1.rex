defmodule Module do

  somefunction(a, b \\ 10)
  somefunction(a, b) ->
    case b of
      5 -> :ok
      _ > :not_ok
    end
  somefunction(a, 5) ->
    enum:map a, b -> b * 5

  something(a, b) ->>
    IO.puts "Hey"


  ~deffun() ->>
    quote do
      yo() ->
        :yo
    end

  ~two() -> 2

end
