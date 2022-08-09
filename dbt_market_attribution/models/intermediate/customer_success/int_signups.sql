with signups as (

    select 
    count(models.user_id) as count_new_signups
    , models.campaign_id
    , models.utm_medium
    , models.total_sessions as total_sessions_before_conversion
    , models.first_touch_points as first_touch_attribution
    from {{ ref('int_attribution_models') }} as models
    group by 2,3,4,5
    
)    

select * from signups