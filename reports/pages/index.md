---
title: 🌲🌳 Trees of San Francisco 🚃🌉
---

<script>
    let myColors = [
      "#D7E4C0",
      "#C6DCBA",
      "#BBC3A4",
      "#B3A398",
      "#638889"
    ]
</script>

## Overview

### Common species

The 3 most common species of trees in San Francisco are the <Value data={common_species_counts} column=species_friendly_name row=0 />, the <Value data={common_species_counts} column=species_friendly_name row=1 />, and the <Value data={common_species_counts} column=species_friendly_name row=2 />.

<BarChart
  data={common_species_counts}
  x="species_friendly_name"
  y="count_of_trees"
  title="Most common species"
  subtitle="Species with more than 3000 trees"
  colorPalette={myColors}
/>

```sql common_species_counts
select
    species_friendly_name,
    count_of_trees,

from dbtree.species

where
  count_of_trees > 3000 and
  species_friendly_name != 'Unknown'

order by count_of_trees desc
```

### Trees planted by year

<Dropdown
  name="trees_planted_years"
  data={trees_planted_years}
  value="year"
  defaultValue={2024}
/>

<CalendarHeatmap
    data={trees_planted_per_year}
    date="planted_at_date"
    value=count_of_trees
    title="Trees Planted"
    subtitle="Heatmap of trees planted in selected year"
    yearLabel=true
    colorPalette={myColors}
/>

```sql trees_planted_per_year
select
  planted_at_date,
  count(*) as count_of_trees,

from dbtree.trees

where
  planted_at_date
    between
      '${inputs.trees_planted_years.value}-01-01' and
      '${inputs.trees_planted_years.value}-12-31'

group by 1
```

```sql trees_planted_years
select
  distinct date_part('year', planted_at_date)::int as year

from dbtree.trees

where year is not null

order by 1 desc
```

### Species distribution

In between <Value data={planted_at_date_range} column=start fmt='longdate' /> and <Value data={planted_at_date_range} column=end fmt='longdate' />, the most common species of trees planted were the <Value data={top_species_planted_in_date_range} column=species_friendly_name row=0 />, the <Value data={top_species_planted_in_date_range} column=species_friendly_name row=1 />, and the <Value data={top_species_planted_in_date_range} column=species_friendly_name row=2 />.

<DateRange
  name="planted_at_dates"
  title="Planted between dates"
  dates=planted_at_month
/>

<Dropdown
  name="planted_at_species"
  data={unique_species}
  value="species_friendly_name"
  title="Filter by species"
  multiple=true
/>

<BarChart
   data={trees_planted}
   x="planted_at_month"
   y="count_of_trees"
   title="Trees Planted"
   subtitle="Trees planted per month"
   colorPalette={myColors}
 />

```sql trees_planted
select
  date_trunc('month', planted_at_date) as planted_at_month,
  count(*) as count_of_trees

from dbtree.trees

where
  species_friendly_name in ${inputs.planted_at_species.value} and
  planted_at_date
    between
      '${inputs.planted_at_dates.start}' and
      '${inputs.planted_at_dates.end}'

group by 1
```

```sql top_species_planted_in_date_range
select
  species_friendly_name,
  count(*) as count_of_trees

from dbtree.trees

where
  planted_at_date
    between
      '${inputs.planted_at_dates.start}' and
      '${inputs.planted_at_dates.end}'

  and species_friendly_name != 'Unknown'

group by 1
order by count_of_trees desc
limit 3
```

```sql planted_at_date_range
select
  cast('${inputs.planted_at_dates.start}' as datetime) as start,
  cast('${inputs.planted_at_dates.end}' as datetime) as end
```

```sql unique_species
select * from dbtree.species
order by count_of_trees desc
```
