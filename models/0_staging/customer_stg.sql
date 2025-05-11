select *
from (
      select *, row_number() over (partition by customer_id order by load_date des) as rownum
      from {{ source('landing','tbs_customers')}}
      )
where rownum = 1