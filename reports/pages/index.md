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

## Species counts

<BarChart
  data={common_species_counts}
  x="species"
  y="count_of_trees"
  title="Most common species"
  subtitle="Species with more than 3000 trees"
  colorPalette={myColors}
/>

```sql common_species_counts
select
    species,
    count_of_trees,

from dbtree.species

where count_of_trees > 3000
```

### Trees planted by year

<Dropdown
  name="trees_planted_years"
  data={trees_planted_years}
  value="year"
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
  distinct date_part('year', planted_at_date) as year

from dbtree.trees

where year is not null

order by 1 desc
```

<DateRange
  name="planted_at_dates"
  title="Planted between dates"
  dates=planted_at_month
/>
<Dropdown
  name="planted_at_species"
  data={planted_at_species}
  value="species"
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
  species,
  count(*) as count_of_trees

from dbtree.trees

where
  friendly_name in ${inputs.planted_at_species.value} and
  planted_at_date
    between
      '${inputs.planted_at_dates.start}' and
      '${inputs.planted_at_dates.end}'

group by 1, 2
```

```sql planted_at_species
select
  $$friendly_name$$ as species

from dbtree.species

order by count_of_trees desc
```
