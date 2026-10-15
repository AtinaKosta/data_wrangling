
#task 1 ARRANGE function
penguins |> arrange(body_mass) |> head()
penguins |> arrange(desc(flipper_len)) |> head()
penguins |> arrange(desc(species), desc(bill_len)) |> head()
penguins |> relocate(bill_len, .after = species) |> relocate(bill_dep, .after = species) |> relocate(flipper_len, .after = species) |> relocate(body_mass, .after = species) |> head()
penguins |> relocate(year, .after = sex) |> head()


#task 2 FILTER function
penguins |> filter(species == "Adelie") |> count()
penguins |> count(island) |> slice_max(n, n = 1) |> pull(island)
penguins |> filter(species == "Gentoo" & body_mass > 5000) |> count()
penguins |> filter(sex == "male" | sex == "female") |> count()
penguins |> filter(body_mass < 3500) |> filter(bill_len < 35) |> count()
penguins |> filter(body_mass < 3500 & bill_len < 35) |> count()

#task 3 SELECT function
penguins |> select(bill_len:body_mass) |> head()
penguins |> select(starts_with("bill")) |> head()
penguins |> select(ends_with("s")) |> head()
penguins |> select(!species) |> head()
penguins |> select(starts_with("b") | starts_with("f")) |> head()
penguins |> select(starts_with("b") & ends_with("f")) |> head()
penguins |> select(contains("_")) |> head()

penguins |> distinct() |> head()
penguins |> distinct(year) |> head()
penguins |> distinct(species, island) |> head()
penguins |> distinct(species, island) |> head()
penguins |> filter(body_mass > 4000) |> select(sex) |> count(sex)
penguins |> filter(species == "Gentoo") |> filter(island == "Biscoe") |> distinct(year) |> count()
