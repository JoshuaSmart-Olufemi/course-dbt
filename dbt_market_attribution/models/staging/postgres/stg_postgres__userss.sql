with userss as (

    select * from {{source('postgres', 'userss')}}

)

select * from userss