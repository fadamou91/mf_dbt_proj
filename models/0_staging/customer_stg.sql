select *
from (
      select *, row_number() over (partition by customer_id order by dat_load desc) as rownum
      from {{ source('landing','tbs_customers') }}
      )
where rownum = 1