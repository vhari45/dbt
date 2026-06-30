{{ config(materialized='view') }}

select a.id,
    a.user_id,
    a.user_id as customer_id,
    a.order_date,
    a.status,
    b.first_name,
    b.last_name,
    b.first_name||b.last_name||'@gmail.com' as email,
    c.orderid as order_id,
    c.paymentmethod,
    c.amount
    -- a.order_id,
    -- a.customer_id,
    -- a.order_date,
    -- a.status,
    -- total_amount
from {{ source('jaffle_shop', 'orders') }} a
left join {{source('jaffle_shop', 'customers')}} b
on a.user_id = b.id
left join {{source('stripe', 'payment')}} c
on a.id = c.orderid
where a.status != 'returned'