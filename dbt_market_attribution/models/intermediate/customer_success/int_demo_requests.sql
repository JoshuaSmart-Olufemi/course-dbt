with demos as (

    select 
    count(models.requested_demo) as count_of_demo_requests
    , models.campaign_id
    , models.utm_medium
    , models.total_sessions as total_sessions_before_conversion
    , models.first_touch_points as first_touch_attribution
    from {{ ref('int_attribution_models')}} as models
    where models.requested_demo = 'true'
    group by 2,3,4,5
)

select * from demos