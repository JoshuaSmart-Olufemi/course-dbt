with mrr as (

    select 
    date_trunc('month', charge_month) as the_month
    , sum(amount_usd) over () as sum_usd
    , sum(amount_usd) over (partition by charge_month) as  sum_by_charge_month
    , round(sum(amount_usd) over ()/sum(amount_usd) over (partition by charge_month),1) as mrr
    , models.campaign_id
    , models.utm_medium
    , models.total_sessions as total_sessions_before_conversion
    , models.first_touch_points as first_touch_attribution
    from {{ ref('int_attribution_models')}} as models 
    left join {{ ref('stg_postgres__workspaces')}} as workspaces
    on models.user_id = workspaces.owner_user_id::integer
    left join {{ ref('stg_postgres__charges') }} as charges
    on workspaces.workspace_id = charges.workspace_id
    
)    

select * from mrr 
where mrr is not null 
order by 1 