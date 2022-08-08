with pricing_plans as (

    select * from {{source('postgres', 'pricing_plans')}}

)

select * from pricing_plans
