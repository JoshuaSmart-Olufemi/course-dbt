with chargess as (

    select * from {{source('postgres', 'charges')}}

)

select * from chargess