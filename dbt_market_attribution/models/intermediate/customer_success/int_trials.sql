with trials as (

    select
    count(periods.is_trial) as count_of_trials
    , models.campaign_id
    , models.utm_medium
    , models.total_sessions as total_sessions_before_conversion
    , models.first_touch_points as first_touch_attribution
    from {{ ref('int_attribution_models')}} as models   
    left join {{ ref('stg_postgres__workspaces')}} as workspaces
    on models.user_id = workspaces.owner_user_id::integer
    left join {{ ref('stg_postgres__subscription_periods')}} as periods
    on workspaces.workspace_id = periods.workspace_id 
    where periods.is_trial = 'true'
    and models.dates <= models.created_at 
    and models.dates >= models.created_at + INTERVAL '-30 day'
    and models.utm_medium <> '(none)'
    group by 2,3,4,5

)    

select * from trials