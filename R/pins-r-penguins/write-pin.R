# Connect to the board
board <- pins::board_rsconnect(server = "https://colorado.posit.co/rsc")

# Pin to the board
board |> 
  pins::pin_write(
    palmerpenguins::penguins,
    title = "Pins with R - Palmer Penguins",
    name = "penguins_pins_r_demo",
    type = "csv",
    description = glue::glue(
      "The Palmer Penguin data is from the `palmerpenguin` package. You can,",
      "read more about it here: https://allisonhorst.github.io/palmerpenguins/",
      .sep = " "
    ),
    versioned = TRUE,
    metadata = list(
      source = "https://allisonhorst.github.io/palmerpenguins/",
      data_author = "Allison Horst"
    )
  )

# See all versions
board %>% 
  pins::pin_versions("sam.edwardes/penguins_pins_r_demo")