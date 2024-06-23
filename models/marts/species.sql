with

trees as (

    select *, from {{ ref('sf_trees') }}

),

species as (

    select
        species_friendly_name,
        species_scientific_name,
        'https://wikipedia.org/wiki/'
        || replace(species_scientific_name, ' ', '_') as wikipedia_link,
        count(*) as count_of_trees,

    from trees

    group by 1, 2

)

select *, from species
