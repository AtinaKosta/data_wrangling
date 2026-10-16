
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

#task 4 FILTER and DISTINCT functions
penguins |> distinct() |> head()
penguins |> distinct(species, island) |> head()
penguins |> filter(body_mass > 4000) |> select(sex) |> count(sex)
penguins |> filter(species == "Gentoo") |> filter(island == "Biscoe") |> distinct(year) |> count()

#task 5 MUTATE
penguins |> 
  mutate(bill_dim_ratio = bill_len/bill_dep) |> 
  arrange(desc(bill_dim_ratio)) |>
  select(contains("_")) |>
  head()

penguins |>
  mutate(body_mass_kg = body_mass) |>
  select(contains("_")) |> 
  head()

penguins |>
  mutate(flipper_to_mass_ratio = flipper_len / body_mass) |>
  arrange(desc(flipper_to_mass_ratio)) |>
  head()

penguins |>
  mutate(heavy = body_mass > 4.5) |>
  head()

library(dplyr)
#Task 6 MUTATE and CASE_WHEN
penguins |> 
  mutate(flipper_class = case_when(
    flipper_len < 190 ~ "short",
    flipper_len <= 210 ~ "medium",
    TRUE ~ "long"
  )) |> 
  distinct(species, flipper_class)

#Task 7 MUTATE and CASE_WHEN practice
penguins |> 
  mutate(size = case_when(
    flipper_len > 205 & 
      body_mass > 5000 ~ "big",
    flipper_len < 190 & 
      body_mass < 3500 ~ "small",
    TRUE ~ "medium"
  )) |> 
  ggplot(mapping = aes(flipper_len,
                       body_mass,
                       colour = size,
)) +
  geom_point()

penguins |> rename(f_len = flipper_len) |> head()

penguins |> group_by(species, island) |> head()

penguins |> 
  group_by(species) |>
  summarize(mean_body_mass = mean(body_mass, na.rm = TRUE))


#Task 7 group_by different variables

penguins |> 
  group_by(species, island) |>
  summarize(mean_body_mass = mean(body_mass, na.rm = TRUE))

penguins |> 
  group_by(species) |> 
  filter(body_mass == max(body_mass, na.rm = TRUE))


ggplot(
  data = penguins,
  mapping = aes(x = bill_len,
                y = bill_dep,
                shape = island, 
                colour = species)) +
  geom_point()

