{#dynamic test to check records required number in each table#}
{%set required_records = {'tbs_orders': 50,
                          'tbs_order_details': 50,
                          'tbs_customers': 20,
                          'tbs_products': 50,
                          'tbs_inventory': 50,
                          'tbs_suppliers': 10}
%}

{% for ma_table, required_record in required_records.items()%}
select '{{ ma_table }}' as table_name,
       (select count(*) from {{ source('landing', ma_table) }}) as current_record_count,
       {{ required_record }} as expected_record_count
from {{ source('landing', ma_table) }}
where (select count(*) from {{ source('landing', ma_table) }}) < {{ required_record }}

{% if not loop.last %} union all {% endif %}
{% endfor %}