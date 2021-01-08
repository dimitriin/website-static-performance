DROP TABLE web_static_performance_stream;
CREATE TABLE IF NOT EXISTS web_static_performance_stream (
    timestamp DateTime('UTC'),
    clientTimestamp DateTime('UTC'),
    locationScheme String,
    locationHost String,
    locationPort Nullable(UInt16),
    locationPath String,
    locationQuery Nullable(String),
    locationFragment Nullable(String),
    resourceScheme String,
    resourceHost String,
    resourcePort Nullable(UInt16),
    resourcePath String,
    resourceQuery Nullable(String),
    resourceFragment Nullable(String),
    resourceDuration Float64,
    resourceTransferSize Float64,
    connectionType String,
    connectionDownlinkMax Float64,
    partyId String,
    sessionId String,
    pageViewId String,
    eventId String,
    userAgentFamily String,
    userAgentDeviceCategory String,
    userAgentOsFamily String,
    geoIP_ip String,
    geoIP_country_code String,
    geoIP_region_code String,
    geoIP_city String,
    geoIP_zip_code String,
    geoIP_latitude Float64,
    geoIP_longitude Float64
) ENGINE = Kafka
      SETTINGS
          kafka_broker_list = 'kafka:9092',
          kafka_topic_list = 'web_static_performance_stream',
          kafka_group_name = 'web_static_performance_stream_consumer',
          kafka_format = 'JSONEachRow';

DROP TABLE web_static_performance;
CREATE TABLE web_static_performance (
    timestamp DateTime('UTC'),
    clientTimestamp DateTime('UTC'),
    locationScheme String,
    locationHost String,
    locationPort Nullable(UInt16),
    locationPath String,
    locationQuery Nullable(String),
    locationFragment Nullable(String),
    resourceScheme String,
    resourceHost String,
    resourcePort Nullable(UInt16),
    resourcePath String,
    resourceQuery Nullable(String),
    resourceFragment Nullable(String),
    resourceDuration Float64,
    resourceTransferSize Float64,
    connectionType String,
    connectionDownlinkMax Float64,
    partyId String,
    sessionId String,
    pageViewId String,
    eventId String,
    userAgentFamily String,
    userAgentDeviceCategory String,
    userAgentOsFamily String,
    geoIP_ip String,
    geoIP_country_code String,
    geoIP_region_code String,
    geoIP_city String,
    geoIP_zip_code String,
    geoIP_latitude Float64,
    geoIP_longitude Float64
) ENGINE = MergeTree()
      ORDER BY (locationHost, locationPath, resourceHost, resourcePath)
      PARTITION BY timestamp
      TTL timestamp + INTERVAL 1 MONTH;

DROP TABLE web_static_performance_view;
CREATE MATERIALIZED VIEW web_static_performance_view TO web_static_performance
AS SELECT * FROM web_static_performance_stream;