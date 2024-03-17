---
title: History of Trees Planted
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

San Francisco's urban forest has been growing for over a century. This heatmap shows the number of trees planted as far back as the data goes. The earliest tree in the dataset was planted in <Value data={trees_planted_all_time_start_year} fmt="YYYY"/>!

<CalendarHeatmap
    data={trees_planted_all_time}
    date="planted_at_date"
    value=count_of_trees
    title="Trees Planted"
    subtitle="Heatmap of trees planted all time"
    yearLabel=true
    colorPalette={myColors}
/>

```sql trees_planted_all_time
select
  planted_at_date,
  count(*) as count_of_trees,

from dbtree.trees

group by 1
order by 1 desc
```

```sql trees_planted_all_time_start_year
select
  date_part('year', min(planted_at_date)) as start_year

from ${trees_planted_all_time}
```
