with

trees as (

    select *, from {{ ref('stg_sf_trees') }}

),

species as (

    select
        species,
        count(*) as count_of_trees,

    from trees

    group by 1

)

select *, from species
