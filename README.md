# Scalixir

Scala syntax in Elixir!

![image](https://s32.postimg.org/3ru7vw2ad/Screen_Shot_2016_06_16_at_17_04_47.png)

On the left hand side Scalixir
On the righthand Elixir equivalent


# Features
- `{` and `}` instead of `do` and `end` - No more tedious block separators!
- `(` and `)` instead of `{` and `}` for tuples. Just because. And also for easier implementation of the feature above
- Single line defs declarations with `=`

# Incoming features
- Lambda expressions `{ _ * 2 }`
    - No more `Enum.map fn a -> a * 2 end`. Now its time for `Enum.map {_ * 2}`
    - Imagine a world where `|> (&(&1 * &2)).()` becomes `|> {_ * _}.()`

# Instalation

Install Scalixir globally with

`mix archive.install https://github.com/wende/scalixir/releases/download/v0.1/scalixir-0.0.1.ez`

Then add it yo your project by adding these two lines to your `Mix.exs` file

```scala
def project do
    [app: :my_app,
     ...
     compilers: [:scalixir, :yecc, :leex, :erlang, :elixir, :app],
     elixirc_paths: ["lib", ".sex"]
    ]
  end
```

Now you can create `*.sex` files anywhere in your project and have fun with Scalixir

# Example file

```ruby
# Brackets instead of do/end blocks
defmodule MyModule {
  def somefunction(a, b \\ 10)
  def somefunction(a, b){
    case File.read("somefile"){
      # Parenthesis for tuples
      (:ok, content) -> content
      _ -> :not_ok
    }
  }
  def somefunction(a, 5){
    # Nothing yet here. But it will look like Enum.map a, { _ * 5 }
    Enum.map(a, fn b -> b * 5 end)
  }

  defmacro something(a, b){
    IO.puts "hey"
  }

  defmacrop deffun(){
    quote{
      def yo(){
        :yo
      }
    }
  }

  # Single line defs declarations with `=`
  defp two() = 2
}

```

