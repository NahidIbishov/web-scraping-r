library(rvest)
library(ggplot2)
library(dplyr)
library(data.table)


# HTTP GET request

link = "https://en.wikipedia.org/wiki/List_of_Formula_One_drivers"

page = read_html(link)

# Rendering the HTML code into table

drivers_F1 = html_element(page, "table.sortable") %>% html_table()

head(drivers_F1)
tail(drivers_F1)

drivers_F1 = data.table(drivers_F1)
drivers_F1$`Seasons competed` = gsub("–","-",drivers_F1$`Seasons competed`)

# Extracting only the first character. The maximum number of championships won by a driver is 7, 
# so it is fine to extract only the first digit.

drivers_F1$`Drivers' Championships`= substr(drivers_F1$`Drivers' Championships`,start = 1,stop = 1)

# Removing unwanted special characters from every driver name

drivers_F1$`Driver name`= gsub("[\\^~*]","",drivers_F1$`Driver name`)

# Eliminating the last row that contains the name of the variables

drivers_F1=drivers_F1[-.N]

# Which country has the largest number of wins?

Champ_country = drivers_F1 %>% group_by(Nationality) %>% 
  summarise(Total_championships=sum(as.double(`Drivers' Championships`))) %>%
  arrange(desc(Total_championships)) 

# Who has the most Championships?

Champ_pilot = drivers_F1 %>%
  group_by(`Driver name`) %>%
  summarise(Pilot_name = sum(as.double(`Drivers' Championships`))) %>%
  arrange(desc(Pilot_name))

drivers_F1$`Pole positions` = gsub("[^0-9]","",drivers_F1$`Pole positions`)

# Relation between the number of Championships won and the number of race pole positions

drivers_F1$`Drivers' Championships` = as.numeric(drivers_F1$`Drivers' Championships`)
drivers_F1$`Pole positions`=as.numeric(drivers_F1$`Pole positions`)

cor(x=drivers_F1$`Pole positions`,drivers_F1$`Drivers' Championships`)

drivers_F1 %>%
  filter(`Pole positions` > 1) %>%
  ggplot(aes(x = as.double(`Pole positions`), y = as.double(`Drivers' Championships`))) +
  geom_point(position = "jitter") +
  labs(y = "Championships won", x = "Pole positions") +
  theme_minimal()

write.csv(drivers_F1,"f1_drivers.csv", row.names = FALSE)
write.csv(Champ_pilot,"f1_champions_pilots.csv")
write.csv(Champ_country,"f1_champions_pilots.csv")
