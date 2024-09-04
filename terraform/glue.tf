resource "aws_glue_catalog_database" "raw" {
  name        = "currency_exchange_raw"
  description = "Database to store raw data related to the Currency Exchange"
}

resource "aws_glue_catalog_table" "currency_exchange" {
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
  }
}
