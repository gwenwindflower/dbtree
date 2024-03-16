with

trees as (

    select *, from {{ ref('stg_sf_trees') }}

),

species as (

    select
        species,
        count(*) as count_of_trees,

    from trees

    where
        species is not null
        and species != 'Tree(s) ::'

    group by 1

)

select *, from species
