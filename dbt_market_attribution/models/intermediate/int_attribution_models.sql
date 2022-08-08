with attribution_models as (  

    select 
    *,
    case
        when total_sessions = 1 then 1.0
        when total_sessions = 2 then 0.5
        when session_number = 1 then 0.4
        when session_number = total_sessions then 0.4
        else 0.2 / (total_sessions - 2)
    end as forty_twenty_forty_points,

    case
        when session_number = 1 then 1.0
        else 0.0
    end as first_touch_points,

    case
        when session_number = total_sessions then 1.0
        else 0.0
    end as last_touch_points,

    1.0 / total_sessions as linear_points
    from {{ ref('int_sessions_before_conversion')}}
)

select * from attribution_models 