with sessions_before_conv as ( 

    select 
    sess.dates 
    , sess.session_id
    , sess.user_id
    , sess.campaign as campaign_id
    , substring(split_part(sess.source_medium,'/',2) from 2 for 61) as utm_medium
    , sess.requested_demo
    , users.created_at
    from {{ ref('stg_postgres__ga_sessions')}} as sess
    left join {{ ref('stg_postgres__userss')}} as users
    on sess.user_id::int = users.users_id::int
    where sess.dates <= users.created_at 
    and sess.dates >= users.created_at + INTERVAL '-30 day'
)
, total_sessions_and_session_index as (

    select
    *,
    count(*) over (partition by sessions_before_conv.user_id) as total_sessions,

    row_number() over (partition by sessions_before_conv.user_id order by sessions_before_conv.dates) as session_number
    
from sessions_before_conv
where sessions_before_conv.dates <= sessions_before_conv.created_at 
and sessions_before_conv.dates >= sessions_before_conv.created_at + INTERVAL '-30 day'
)

select * from total_sessions_and_session_index

