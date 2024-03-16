with

source as (

    select *, from {{ source('sf_trees', 'tree_list') }}

),

staged as (

    select
        treeid as tree_id,
        qlegalstatus as legal_status,
        qspecies as species,
        qaddress as address,
        siteorder as site_order,
        qsiteinfo as site_info,
        planttype as plant_type,
        qcaretaker as caretaker,
        qcareassistant as care_assistant,
        plantdate as plant_date,
        dbh,
        plotsize as plot_size,
        permitnotes as permit_notes,
        xcoord as x_coord,
        ycoord as y_coord,
        latitude,
        longitude,
        location,
        "Fire Prevention Districts" as fire_prevention_districts,
        "Zip Codes" as zip_codes,
        "Analysis Neighborhoods" as neighborhood,
    from source

)

select *, from staged
