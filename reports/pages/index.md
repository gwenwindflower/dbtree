---
title: 🌲🌳 Trees of San Francisco 🚃🌉
---

## Species counts

<BarChart
  data={species_counts}
  x="species"
  y="count_of_trees"
  title="Most common species"
/>

```sql species_counts
select
    species,
    count_of_trees,

from dbtree.species

where count_of_trees > 3000

```
