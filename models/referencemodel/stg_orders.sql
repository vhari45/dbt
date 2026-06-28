{{ config(materialized='view') }}

select
    id              as order_id,
    customer_id,
    order_date,
    status,
    amount
from {{ source('jaffle_shop', 'orders') }}
where status != 'returned'