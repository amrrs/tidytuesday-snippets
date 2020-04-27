library(tidyverse)
library(tidytext)
library(hrbrthemes)

gdpr_violations <- readr::read_tsv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-04-21/gdpr_violations.tsv')



update_geom_font_defaults(font_rc_light)
gdpr_violations %>% 
 select(authority, summary) %>% 
 unnest_tokens(word, summary) %>% 
 anti_join(stop_words) %>% 
 count(word, sort = TRUE) %>% 
 head(30) %>% 
 mutate(word = fct_reorder(word,n)) %>% 
 ggplot() + geom_col(aes(x = n, y = word), fill = ft_cols$red)  +
 gghighlight::gghighlight(word == 'consent') +
 labs(title = "Most used words in GDPR Violation Summary",
      subtitle = "using {tidytext}, theme by {hrbrthemes}",
      caption = "Data Source: Tidy Tuesday") +
 theme_ft_rc(axis_text_size = 15) +
 ggsave("gdpr.png", width = 15, height = 10)
