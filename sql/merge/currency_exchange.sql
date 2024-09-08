merge into ${curated_database_name}.${curated_table_name} as target_table
using (
    select *
    from ${raw_database_name}.${raw_table_name}
) as source_table
on source_table.code = target_table.base_currency_code
    and source_table.codein = target_table.quote_currency_code
    and source_table.timestamp  = target_table.timestamp 
    and source_table.ingestion_datetime = target_table.ingestion_datetime

when not matched then 
    insert (
          base_currency_code
        , quote_currency_code
        , currency_pair
        , high
        , low
        , change_value
        , percent_change
        , bid_price
        , ask_price
        , timestamp
        , create_date
        , ingestion_datetime 
    )
    values (
          source_table.code
        , source_table.codein
        , source_table.name
        , source_table.high
        , source_table.low
        , source_table.varbid
        , source_table.pctchange
        , source_table.bid
        , source_table.ask
        , source_table.timestamp
        , source_table.create_date
        , source_table.ingestion_datetime 
    )