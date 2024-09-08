resource "aws_glue_catalog_database" "raw" {
  name        = "currency_exchange_raw"
  description = "Database to store raw data related to the Currency Exchange"
}

resource "aws_glue_catalog_table" "currency_exchange_raw" {
  name          = "currency_exchange"
  database_name = aws_glue_catalog_database.raw.name
  description   = "Table with periodic Currency Exchange between relevant currencies."

  table_type = "EXTERNAL_TABLE"

  partition_keys {
    name    = "currency"
    comment = "Currency of the Exchange"
    type    = "String"
  }

  partition_keys {
    name    = "date"
    comment = "The date of the currency of the Exchange"
    type    = "String"
  }

  storage_descriptor {
    location      = "s3://00-raw-753251897225/currency_exchange/"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    ser_de_info {
      serialization_library = "org.openx.data.jsonserde.JsonSerDe"
    }

    columns {
      name = "code"
      type = "string"
    }

    columns {
      name = "codein"
      type = "string"
    }

    columns {
      name = "name"
      type = "string"
    }

    columns {
      name = "high"
      type = "string"
    }

    columns {
      name = "low"
      type = "string"
    }

    columns {
      name = "varBid"
      type = "string"
    }

    columns {
      name = "pctChange"
      type = "string"
    }

    columns {
      name = "bid"
      type = "string"
    }

    columns {
      name = "ask"
      type = "string"
    }

    columns {
      name = "timestamp"
      type = "string"
    }

    columns {
      name = "create_date"
      type = "string"
    }

    columns {
      name = "ingestion_datetime"
      type = "string"
    }
  }
}

resource "aws_glue_catalog_database" "curated" {
  name        = "currency_exchange_curated"
  description = "Database to store curated data related to the Currency Exchange"
}

resource "aws_glue_catalog_table" "currency_exchange" {
  name          = "currency_exchange"
  database_name = aws_glue_catalog_database.curated.name
  description   = "Table with periodic Currency Exchange between relevant currencies."

  table_type = "EXTERNAL_TABLE"

  open_table_format_input {
    iceberg_input {
      metadata_operation = "CREATE"
    }
  }

  storage_descriptor {
    location = "s3://01-curated-753251897225/currency_exchange/"
    columns {
      name    = "base_currency_code"
      type    = "string"
      comment = "Represents the currency being quoted or valued in terms of another currency."
    }

    columns {
      name    = "quote_currency_code"
      type    = "string"
      comment = "Represents the currency against which the base currency is quoted."
    }

    columns {
      name    = "currency_pair"
      type    = "string"
      comment = "A string that describes the combination of two currencies being compared or exchanged."
    }

    columns {
      name    = "high"
      type    = "string"
      comment = "The highest exchange rate reached for the currency pair during the specified period."
    }

    columns {
      name    = "low"
      type    = "string"
      comment = "The lowest exchange rate reached for the currency pair during the specified period."
    }

    columns {
      name    = "change_value"
      type    = "string"
      comment = "Indicates the absolute change in the bid price of the currency pair from its last recorded value."
    }

    columns {
      name    = "percent_change"
      type    = "string"
      comment = "Reflects the percentage change in the bid price from the previous period."
    }

    columns {
      name    = "bid_price"
      type    = "string"
      comment = "The price at which buyers are willing to purchase the base currency."
    }

    columns {
      name    = "ask_price"
      type    = "string"
      comment = "The price at which sellers are willing to sell the base currency."
    }

    columns {
      name    = "timestamp"
      type    = "string"
      comment = "A UNIX timestamp that indicates when the exchange rate data was captured."
    }

    columns {
      name    = "create_date"
      type    = "string"
      comment = "The date and time when the exchange rate data was most recently updated."
    }

    columns {
      name    = "ingestion_datetime"
      type    = "string"
      comment = "The specific date and time when the data was ingested or entered into the system or database."
    }
  }
}
