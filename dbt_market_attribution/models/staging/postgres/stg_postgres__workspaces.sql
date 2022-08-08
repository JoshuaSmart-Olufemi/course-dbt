with workspaces as (

    select * from {{source('postgres', 'workspaces')}}

)

select * from workspaces 