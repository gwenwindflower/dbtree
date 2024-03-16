with

source as (

    select * from {{ source('sf_trees', 'tree_list') }}

),

staged as (

    select
        TreeID as tree_id,
        qLegalStatus as legal_status,
        qSpecies as species,
        qAddress as address,
        SiteOrder as site_order,
        qSiteInfo as site_info,
        PlantType as plant_type,
        qCaretaker as caretaker,
        qCareAssistant as care_assistant,
        PlantDate as plant_date,
        DBH as dbh,
        PlotSize as plot_size,
        PermitNotes as permit_notes,
        XCoord as x_coord,
        YCoord as y_coord,
        Latitude as latitude,
        Longitude as longitude,
        Location as location,
        "Fire Prevention Districts" as fire_prevention_districts,
        "Zip Codes" as zip_codes,
        "Analysis Neighborhoods" as neighborhood,
    from source

)

select * from staged
