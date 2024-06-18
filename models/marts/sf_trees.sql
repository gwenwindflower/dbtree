with

sf_trees as (

    select *, from {{ ref('stg_sf_trees') }}

),

clean_up_species as (

    select
        tree_id,
        site_info,
        site_order,
        legal_status,
        permit_notes,
        caretaker,
        care_assistant,
        plot_size,
        address,
        zip_codes,
        neighborhood,
        location,
        x_coord,
        y_coord,
        latitude,
        longitude,
        planted_at_date,
        case
            when plant_type = 'Tree' or plant_type = 'tree' then 'tree'
            when plant_type = 'Landscaping' then 'landscaping'
            else 'unknown'
        end as plant_type,
        split_part(species, ':: ', 1) as species_scientific_name,
        split_part(species, ':: ', 2) as species_friendly_name,


    from sf_trees

)

select *, from clean_up_species
