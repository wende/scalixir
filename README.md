# Scalixir

Scala syntax in Elixir!

![image](https://s32.postimg.org/3ru7vw2ad/Screen_Shot_2016_06_16_at_17_04_47.png)

On the left hand side Scalixir
On the righthand Elixir equivalent


# Features


# Intalation

Install Scalixir globally with

`mix archive.install https://github.com/wende/scalixir/releases/download/v0.1/scalixir-0.0.1.ez`

Then add it yo your project by adding these two lines to your `Mix.exs` file

```elixir
def project do
    [app: :my_app,
     ...
     compilers: [:scalixir, :yecc, :leex, :erlang, :elixir, :app],
     elixirc_paths: ["lib", ".sex"]
    ]
  end
```
