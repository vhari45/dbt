{{ config(materialized='table') }}

select
    c.id,
    c.first_name,
    c.last_name,
    count(o.order_id)      as total_orders,
    sum(o.amount)          as total_spent,
    min(o.order_date)      as first_order_date,
    max(o.order_date)      as last_order_date
from {{ ref('stg_orders') }} c
left join {{ ref('int_orders_filtered') }} o
    on c.customer_id = o.customer_id
group by 1, 2, 3