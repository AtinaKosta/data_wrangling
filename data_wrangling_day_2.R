
#task 1
penguins |> arrange(body_mass) |> head()
penguins |> arrange(desc(flipper_len)) |> head()
penguins |> arrange(desc(species), desc(bill_len)) |> head()
penguins |> relocate(bill_len, .after = species) |> relocate(bill_dep, .after = species) |> relocate(flipper_len, .after = species) |> relocate(body_mass, .after = species) |> head()
penguins |> relocate(year, .after = sex) |> head()


#task 2
penguins |> filter(species == "Adelie") |> count()
penguins |> count(island) |> slice_max(n, n = 1) |> pull(island)
penguins |> filter(species == "Gentoo" & body_mass > 5000) |> count()
penguins |> filter(sex == "male" | sex == "female") |> count()
penguins |> filter(body_mass < 3500) |> filter(bill_len < 35) |> count()
penguins |> filter(body_mass < 3500 & bill_len < 35) |> count()


