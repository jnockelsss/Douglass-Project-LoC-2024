# load required packages

library(striprtf)
library(tidytext)
library(dplyr)
library(ggplot2)
library(stringr)
library(readtext)
library(readr)

# upload texts from local files and pre-process, keeping text after Chapter I 
# to cut prefaces, table of contents and boilerplating

files <- c("/Users/joenockels/Documents/Douglass2024/DD.txt",
           "/Users/joenockels/Documents/Douglass2024/NLFD.rtf", 
           "/Users/joenockels/Documents/Douglass2024/MBMF.rtf",
           "/Users/joenockels/Documents/Douglass2024/LTFD.rtf")

all_texts <- readtext(files) %>%
  mutate(title = tools::file_path_sans_ext(basename(doc_id))) %>%
  select(title, text)

ch_pattern <- regex("(?s).*?(CHAPTER\\s+(?:[IVXLCDM]+|[0-9]+|[A-Z]+)(?:[\\s\\.:\\-–—]*)?)",
                    ignore_case = TRUE)

all_texts <- all_texts %>%
  mutate(
    has_chapter = str_detect(text, ch_pattern),
    text = if_else(
      has_chapter,
      # Keep everything starting from the first "CHAPTER ..." match
      str_replace(text, ch_pattern, "\\1"),
      text
    )
  )

# convert to tidy text format

tidy_texts <- all_texts %>%
  unnest_tokens(word, text)

# create a dictionary of pronoun terms, as a means to interrogate Douglass's 
# address

pronoun_dict <- tibble::tibble(
  pronoun = c("i","me","us","my","mine","myself","we","ourselves",
              "you","your","yourself","yourselves",
              "they","them","he","him","his","himself",
              "she","her","herself","their"),
  category = c("1st person","1st person","1st person","1st person",
               "1st person","1st person","1st person","1st person",
               "2nd person","2nd person","2nd person","2nd person",
               "3rd person","3rd person","3rd person","3rd person",
               "3rd person","3rd person","3rd person","3rd person",
               "3rd person", "3rd person")
)

pronoun_counts <- tidy_texts %>%
  inner_join(pronoun_dict, by = c("word" = "pronoun")) %>%
  count(title, category, word, sort = TRUE)

# normalise per 1000 words to account for DD's shorter length

text_lengths <- tidy_texts %>%
  count(title, name = "total_words")

pronoun_summary <- pronoun_counts %>%
  group_by(title, category) %>%
  summarise(total = sum(n), .groups = "drop") %>%
  left_join(text_lengths, by = "title") %>%
  mutate(per_1000 = (total / total_words) * 1000)

print(pronoun_summary)

write_csv(pronoun_summary, "/Users/joenockels/Documents/Douglass2024/pronoun_summary.csv")

ggplot(pronoun_summary, aes(x = category, y = per_1000, fill = category)) +
  geom_col() +
  facet_wrap(~ title, scales = "free_y") +
  theme_minimal() +
  theme(
    strip.text = element_text(hjust = 0.5)
  ) +
  labs(title = "Prevalence of address across Douglass's autobiographies", 
       x = "Address", y = "Occurences per 1,000 words")

# find an avg sentence length for each autobiography

sentence_lengths <- all_texts %>%
  rowwise() %>%
  mutate(
    sentences = str_split(text, "(?<=[.!?])\\s+"),
    sentence_word_counts = list(sapply(sentences, function(s) str_count(s, "\\S+"))),
    avg_sentence_length = mean(unlist(sentence_word_counts), na.rm = TRUE)
  ) %>%
  select(title, avg_sentence_length)

sentence_lengths

write_csv(sentence_lengths, "/Users/joenockels/Documents/Douglass2024/sentence_lengths.csv")