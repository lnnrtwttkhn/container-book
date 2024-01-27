table_cheatsheet <- function(name = "all") {
  library(here)
  library(jsonlite)
  library(dplyr)
  library(tidyr)
  json_data <- jsonlite::fromJSON(txt = here::here("cheatsheet.json"))
  df <- json_data %>%
    dplyr::bind_rows(.id = "Chapter") %>%
    tidyr::pivot_longer(cols = -c("Chapter"), names_to = "Command", values_to = "Description") %>%
    dplyr::mutate(Command = sprintf("`%s`", Command)) %>%
    na.omit()
  if (name != "all") {
    df <- df %>%
      dplyr::filter(Chapter == name) %>%
      dplyr::select(Command, Description)
  }
  return(df)
}
