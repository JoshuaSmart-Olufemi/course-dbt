with paid_workspaces as (

    select 
    count(periods.workspace_id) as count_of_paid_workspaces
    , models.campaign_id
    , models.utm_medium
    , models.total_sessions as total_sessions_before_conversion
    , models.first_touch_points as first_touch_attribution
    from {{ ref('int_attribution_models')}} as models   
    left join {{ ref('stg_postgres__workspaces')}} as workspaces
    on models.user_id = workspaces.owner_user_id::integer
    left join {{ ref('stg_postgres__subscription_periods')}} as periods
    on workspaces.workspace_id = periods.workspace_id 
    where periods.finished_on is not null-- if not null it means it is a paid workspace and not a free 30 day subscription
    and models.dates <= models.created_at 
    and models.dates >= models.created_at + INTERVAL '-30 day'
    and models.utm_medium <> '(none)'
    group by 2,3,4,5
)

select * from paid_workspaces