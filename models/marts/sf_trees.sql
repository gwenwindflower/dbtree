with

sf_trees as (

    select * from {{ ref('stg_sf_trees') }}

)

select * from sf_trees
