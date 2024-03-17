with

trees as (

    select *, from {{ ref('sf_trees') }}

),

caretakers as (

    select
        caretaker,
        species_friendly_name,
        count(*) as count_of_trees,

    from trees

    group by 1, 2

)

select *, from caretakers
