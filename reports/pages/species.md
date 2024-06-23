---
title: Species
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

This page lets you scope the data to a single species of tree. It's a bit of a work in progress, but I'm excited to see where it goes!

**NB:** This list is filtered to species with a scientific name in the data, to support the Wikipedia links.

<Dropdown
  data={species}
  name=species_select
  title="Select a species"
  defaultValue="Blue Oak"
  value=species_friendly_name
/>

The <Value data={selected_species} column=species_friendly_name /> is an amazing tree!

<LinkButton url={selected_species[0].wikipedia_link}>
  Read more on Wikipedia!
</LinkButton>

The Wikipedia links are inferred from the listed scientific name in the data, so they're not perfect and may take you to a non-existent page. Sorry! Hopefully I'll find a way around this soon.

```sql selected_species
select * from species where species_friendly_name = '${inputs.species_select.value}'
```

```sql species
select * from dbtree.species
where species_scientific_name is not null
```
