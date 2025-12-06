# F1 Web Scraping in R

R script for scraping Formula 1 driver data from Wikipedia, cleaning it, performing basic analysis, and exporting results as CSV files.

## Packages

```r
library(rvest)
library(dplyr)
library(data.table)
library(ggplot2)
```

## Data Source

Wikipedia – List of Formula One drivers
(https://en.wikipedia.org/wiki/List_of_Formula_One_drivers)

## Workflow

1. Scrape driver table from the page.
2. Clean data: normalize dashes, remove special characters, convert to numeric.
3. Analyze:
- Total championships by driver and country
- Correlation between pole positions and championships
4. Export cleaned datasets:
- `f1_drivers.csv`
-  `f1_champions_pilots.csv`
-  `f1_champions_countries.csv`

## Run Script

```r
source("scraping.R")
```

Outputs are saved to the working directory.

## Repository Structure

```
scraping.R
f1_drivers.csv
f1_champions_pilots.csv
f1_champions_countries.csv
README.md
```
