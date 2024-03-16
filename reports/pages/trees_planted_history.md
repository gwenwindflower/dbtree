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
