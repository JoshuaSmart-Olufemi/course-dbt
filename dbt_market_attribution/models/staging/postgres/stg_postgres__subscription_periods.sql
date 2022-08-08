with subscription_periods as (

    select * from {{source('postgres', 'subscription_periods')}}

)

select * from subscription_periods
