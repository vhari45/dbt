
{{
    config(materialize = 'incremental',unique_key = 'order_id')
}}


select
order_id,
customerid,
order_date,
amount
from {{source ('raw','orders')}}

{
% if is_incremental() %

}
where order_date > (select max(order_date)) from {{this}}
{% endif %}