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

<CalendarHeatmap
    data={trees_planted_2023}
    date="planted_at_date"
    value=count_of_trees
    title="Trees Planted"
    subtitle="Heatmap of trees planted in 2023"
    yearLabel=false
    colorPalette={myColors}
/>

```sql trees_planted_2023
select
  planted_at_date,
  count(*) as count_of_trees,

from dbtree.trees

where planted_at_date between '2023-01-01' and '2023-12-31'

group by 1
```
