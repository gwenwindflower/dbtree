with

sf_trees as (

    select *, from {{ ref('stg_sf_trees') }}

),

clean_up_species as (

    select
        tree_id,
        legal_status,
        address,
        site_order,
        site_info,
        plant_type,
        caretaker,
        care_assistant,
        planted_at_date,
        plot_size,
        permit_notes,
        x_coord,
        y_coord,
        latitude,
        longitude,
        location,
        zip_codes,
        neighborhood,
        case
            when
                (
                    species is null
                    or species = ''
                    or species = 'Tree(s) ::'
                )
                then 'Unknown'
            else replace(species, ':: ', '')
        end as species,

    from sf_trees
)

select *, from clean_up_species
