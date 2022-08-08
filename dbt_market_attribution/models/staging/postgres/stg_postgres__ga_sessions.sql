with ga_sessions as (

    select * from {{source('postgres', 'ga_sessions')}}

)

select * from ga_sessions