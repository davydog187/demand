# Demand

Prototype of using [libring](https://hexdocs.pm/libring/readme.html), a consistent hash ring implementation for Elixir.

## Example

1. Start three nodes

``` shell
# Shell one
$ iex iex --sname a --cookie mmm -S mix

# Shell two
$ iex iex --sname b --cookie mmm -S mix

# Shell three
$ iex iex --sname c --cookie mmm -S mix
```


2. Cluster them

Run [Node.connect/1](https://hexdocs.pm/elixir/Node.html#connect/1) to mesh all the nodes

``` elixir
# Shell three
iex> Node.connect(:"a@DavesLaptop")
iex> Node.connect(:"b@DavesLaptop")
```

3. Observe that the keys map to the same nodes on each node

``` elixir
iex(a@DavesLaptop)4> for key <- 1..20, do: {key, Demand.owner(to_string(key))}
[
  {1, :c@DavesLaptop},
  {2, :c@DavesLaptop},
  {3, :a@DavesLaptop},
  {4, :c@DavesLaptop},
  {5, :b@DavesLaptop},
  {6, :a@DavesLaptop},
  {7, :c@DavesLaptop},
  {8, :a@DavesLaptop},
  {9, :c@DavesLaptop},
  {10, :b@DavesLaptop},
  {11, :c@DavesLaptop},
  {12, :c@DavesLaptop},
  {13, :b@DavesLaptop},
  {14, :a@DavesLaptop},
  {15, :b@DavesLaptop},
  {16, :b@DavesLaptop},
  {17, :c@DavesLaptop},
  {18, :b@DavesLaptop},
  {19, :b@DavesLaptop},
  {20, :b@DavesLaptop}
]
```

``` elixir
iex(b@DavesLaptop)4> for key <- 1..20, do: {key, Demand.owner(to_string(key))}
[
  {1, :c@DavesLaptop},
  {2, :c@DavesLaptop},
  {3, :a@DavesLaptop},
  {4, :c@DavesLaptop},
  {5, :b@DavesLaptop},
  {6, :a@DavesLaptop},
  {7, :c@DavesLaptop},
  {8, :a@DavesLaptop},
  {9, :c@DavesLaptop},
  {10, :b@DavesLaptop},
  {11, :c@DavesLaptop},
  {12, :c@DavesLaptop},
  {13, :b@DavesLaptop},
  {14, :a@DavesLaptop},
  {15, :b@DavesLaptop},
  {16, :b@DavesLaptop},
  {17, :c@DavesLaptop},
  {18, :b@DavesLaptop},
  {19, :b@DavesLaptop},
  {20, :b@DavesLaptop}
]
```

``` elixir
iex(c@DavesLaptop)4> for key <- 1..20, do: {key, Demand.owner(to_string(key))}
[
  {1, :c@DavesLaptop},
  {2, :c@DavesLaptop},
  {3, :a@DavesLaptop},
  {4, :c@DavesLaptop},
  {5, :b@DavesLaptop},
  {6, :a@DavesLaptop},
  {7, :c@DavesLaptop},
  {8, :a@DavesLaptop},
  {9, :c@DavesLaptop},
  {10, :b@DavesLaptop},
  {11, :c@DavesLaptop},
  {12, :c@DavesLaptop},
  {13, :b@DavesLaptop},
  {14, :a@DavesLaptop},
  {15, :b@DavesLaptop},
  {16, :b@DavesLaptop},
  {17, :c@DavesLaptop},
  {18, :b@DavesLaptop},
  {19, :b@DavesLaptop},
  {20, :b@DavesLaptop}
]
```

4. Kill a node, observe that keys move

(Kill node c)

``` elixir
iex(a@DavesLaptop)5> for key <- 1..20, do: {key, Demand.owner(to_string(key))}
[
  {1, :a@DavesLaptop},
  {2, :a@DavesLaptop},
  {3, :a@DavesLaptop},
  {4, :a@DavesLaptop},
  {5, :b@DavesLaptop},
  {6, :a@DavesLaptop},
  {7, :a@DavesLaptop},
  {8, :a@DavesLaptop},
  {9, :a@DavesLaptop},
  {10, :b@DavesLaptop},
  {11, :a@DavesLaptop},
  {12, :a@DavesLaptop},
  {13, :b@DavesLaptop},
  {14, :a@DavesLaptop},
  {15, :b@DavesLaptop},
  {16, :b@DavesLaptop},
  {17, :a@DavesLaptop},
  {18, :b@DavesLaptop},
  {19, :b@DavesLaptop},
  {20, :b@DavesLaptop}
]
```

5. Add node back, keys move again


``` elixir
iex(a@DavesLaptop)6> for key <- 1..20, do: {key, Demand.owner(to_string(key))}
[
  {1, :c@DavesLaptop},
  {2, :c@DavesLaptop},
  {3, :a@DavesLaptop},
  {4, :c@DavesLaptop},
  {5, :b@DavesLaptop},
  {6, :a@DavesLaptop},
  {7, :c@DavesLaptop},
  {8, :a@DavesLaptop},
  {9, :c@DavesLaptop},
  {10, :b@DavesLaptop},
  {11, :c@DavesLaptop},
  {12, :c@DavesLaptop},
  {13, :b@DavesLaptop},
  {14, :a@DavesLaptop},
  {15, :b@DavesLaptop},
  {16, :b@DavesLaptop},
  {17, :c@DavesLaptop},
  {18, :b@DavesLaptop},
  {19, :b@DavesLaptop},
  {20, :b@DavesLaptop}
]
```
