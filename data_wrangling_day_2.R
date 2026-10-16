
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

#Day 3 Plotting data
ggplot(data = penguins,
       mapping = aes(x = flipper_len,
                     y = body_mass)) +
  geom_point()

ggplot(data = penguins,
mapping = aes(x = bill_len,
y = bill_dep)) +
  labs(title = "Bill length and depth in penguins",
x = "Bill length (mm)",
y = "Bill depth (mm)") +
  theme_minimal() +
  geom_point()

#example 2
ggplot(data = penguins,
       mapping = aes(x = bill_len,
                     y = bill_dep,
                     colour = species)) +
    labs(title = "Bill length and depth in penguins",
       x = "Bill length (mm)",
       y = "Bill depth (mm)",
       colour = "Species") +
  theme_minimal() +
  geom_point()

#example 3
ggplot(data = penguins,
       mapping = aes(x = bill_len,
                     y = bill_dep,
                     colour = "Body_mass",
                     shape = island, 
                colour = species)) +
    labs(title = "Bill length and depth in penguins",
       x = "Bill length (mm)",
       y = "Bill depth (mm)",
       colour = "Species") +
  theme_minimal() +
  geom_point()

#example 4
ggplot(data = penguins,
       mapping = aes(x = bill_len,
                     y = bill_dep,
                     colour = body_mass,
                     shape = species)) +
    labs(title = "Bill length and depth in penguins",
       x = "Bill length (mm)",
       y = "Bill depth (mm)",
       colour = "Species") +
  theme_minimal() +
  geom_point()


#example 5
ggplot(data = penguins,
       mapping = aes(x = bill_len,
                     y = bill_dep,
                     colour = body_mass,
                     shape = species)) +
    labs(title = "Bill length and depth in three species of penguin",
       x = "Bill length (mm)",
       y = "Bill depth (mm)",
       colour = "Body mass") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold")) +
  geom_point(size = 3,
             alpha = 0.6)


#task 7
ggplot(data = penguins,
       mapping = aes(x = flipper_len,
                     y = bill_dep)) +
      geom_point()

#task 8
ggplot(penguins,
       aes(flipper_len,
           bill_dep)) +
  geom_point()


#reducing to objects
p_flipper_len <- ggplot(data = penguins,
       mapping = aes(x = species,
                     y = flipper_len)) +
    labs(title = "Flipper length of penguins",
       x = "Species",
       y = "Flipper length (mm)") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold"))

plot(p_flipper_len)

?boxplot
p_flipper_len +
  geom_boxplot(outlier.alpha = 0) +
  geom_jitter(size = 3,
              varwidth = 0.25,
              alpha = 0.5)

#plotting next
p_flipper_len +
  geom_boxplot(outlier.alpha = 0) +
  geom_jitter(mapping = aes(colour = species),
              size = 3,
              alpha = 0.6,
              position = position_jitter(
      width = 0.2,
      height = 0,
      seed = 123))

?geom_jitter

#task 10
p_bm_fl <- ggplot(data = penguins,
                  mapping = aes(x = body_mass,
                                y = flipper_len,
                                colour = species))

p_bm_fl +
  geom_point(size = 2,
             alpha = 0.6) +
  facet_wrap(~ island)


#task 11
p_bm_fl +
  geom_point(size = 2,
             alpha = 0.6) +
  facet_grid(sex ~ island)  

install.packages("patchwork")
library(patchwork)

#task 12
p1 <- ggplot(penguins,
              aes(x = bill_dep,
                  y = bill_len,
                  colour = species)) +
      geom_point() +
      labs(title = "Flipper length and depth",
           x = "Bill depth (mm)",
           y = "Bill length (mm)")

p2 <- p_bm_fl +
      labs(title = "Body mass and flipper length",
           x = "Flipper length (mm)",
           y = "Body mass (g)") +
      geom_point() 

p1+p2
p1 / p2

#task 12
p_bm_fl +
  geom_point(size = 2,
             alpha = 0.6) +
  facet_wrap(~ island) +
  geom_smooth(
    mapping = aes(group = island),
    method = "lm",
    colour = "darkgrey")

#task 13
set.seed(0982)
month_data <- tibble(
  date = seq(as.Date("2024-12-01"), 
              as.Date("2024-12-31"), 
              by = "day"),
  count = sample(1:20, 31, replace = TRUE)  # Random counts per day
) |>
  mutate(
    wday = wday(date, label = TRUE, abbr = TRUE),  # Day of the week (Sun-Sat)
    week = (day(date) - 1) %/% 7 + 1  # Week number (1 to 5)
  )

month_data |> head() 

#heatmap visualization
ggplot(data = month_data,
       mapping = aes(x = week, 
                      y = wday, 
                      fill = count)) +
  geom_tile()


#solution
ggplot(data = month_data,
mapping = aes(x = wday,
y = week,
fill = count)) 

ggplot(data = month_data,
       mapping = aes(x = wday,
                     y = week,
                     fill = count)) +
  geom_tile(colour = "white") +
  scale_y_reverse() +
  theme_classic() + # removes background gridlines
  labs(title = "December 2024 Calendar Heatmap",
       x = "Days",
       y = "Week",
       fill = "Count")


#plotting next
p_flipper_len +
  geom_boxplot(outlier.alpha = 0) +
  geom_jitter(mapping = aes(colour = species),
              size = 3,
              alpha = 0.6,
              position = position_jitter(
      width = 0.2,
      height = 0,
      seed = 123))  

?aes



#visualizing change over time
set.seed(02) # Please set this seed for this example

# Create stock price data for three different stocks
dates <- seq.Date(from = as.Date("2024-01-01"), 
                  by = "week", 
                  length.out = 200)

stocks <- tibble(
  date = rep(dates, times = 3),
  stock = rep(c("Stock A", "Stock B", "Stock C"), each = length(dates)),
  price = c(
    100 + cumsum(rnorm(length(dates), mean = 0, sd = 5)),  # Stock A fluctuates around 100
    80 + cumsum(rnorm(length(dates), mean = 0, sd = 4)),   # Stock B fluctuates around 80
    120 + cumsum(rnorm(length(dates), mean = 0, sd = 6))   # Stock C fluctuates around 120
  )
)

#plotting
ggplot(stocks |>  filter(stock == "Stock C"), 
        aes(x = date, 
            y = price)) +
  geom_line() +
  labs(title = "Stock C Price Over Time", 
        x = "Date", 
        y = "Price") +
  theme_minimal()

