#!/bin/bash
# Copyright Broadcom, Inc. All Rights Reserved.
# SPDX-License-Identifier: APACHE-2.0
#
# Environment configuration for scylladb

# The values for all environment variables will be set in the below order of precedence
# 1. Custom environment variables defined below after Bitnami defaults
# 2. Constants defined in this file (environment variables with no default), i.e. BITNAMI_ROOT_DIR
# 3. Environment variables overridden via external files using *_FILE variables (see below)
# 4. Environment variables set externally (i.e. current Bash context/Dockerfile/userdata)

# Load logging library
# shellcheck disable=SC1090,SC1091
. /opt/bitnami/scripts/liblog.sh

export BITNAMI_ROOT_DIR="/opt/bitnami"
export BITNAMI_VOLUME_DIR="/bitnami"

# Logging configuration
export MODULE="${MODULE:-scylladb}"
export BITNAMI_DEBUG="${BITNAMI_DEBUG:-false}"

# By setting an environment variable matching *_FILE to a file path, the prefixed environment
# variable will be overridden with the value specified in that file
scylladb_env_vars=(
    SCYLLADB_MOUNTED_CONF_DIR
    SCYLLADB_CLIENT_ENCRYPTION
    SCYLLADB_CLUSTER_NAME
    SCYLLADB_DATACENTER
    SCYLLADB_ENABLE_REMOTE_CONNECTIONS
    SCYLLADB_ENABLE_RPC
    SCYLLADB_ENABLE_USER_DEFINED_FUNCTIONS
    SCYLLADB_ENABLE_SCRIPTED_USER_DEFINED_FUNCTIONS
    SCYLLADB_ENDPOINT_SNITCH
    SCYLLADB_HOST
    SCYLLADB_INTERNODE_ENCRYPTION
    SCYLLADB_NUM_TOKENS
    SCYLLADB_PASSWORD_SEEDER
    SCYLLADB_SEEDS
    SCYLLADB_PEERS
    SCYLLADB_NODES
    SCYLLADB_RACK
    SCYLLADB_BROADCAST_ADDRESS
    SCYLLADB_AUTOMATIC_SSTABLE_UPGRADE
    SCYLLADB_STARTUP_CQL
    SCYLLADB_IGNORE_INITDB_SCRIPTS
    SCYLLADB_CQL_PORT_NUMBER
    SCYLLADB_JMX_PORT_NUMBER
    SCYLLADB_TRANSPORT_PORT_NUMBER
    SCYLLADB_CQL_MAX_RETRIES
    SCYLLADB_CQL_SLEEP_TIME
    SCYLLADB_INIT_MAX_RETRIES
    SCYLLADB_INIT_SLEEP_TIME
    SCYLLADB_PEER_CQL_MAX_RETRIES
    SCYLLADB_PEER_CQL_SLEEP_TIME
    SCYLLADB_DELAY_START_TIME
    SCYLLADB_AUTO_SNAPSHOT_TTL
    ALLOW_EMPTY_PASSWORD
    SCYLLADB_AUTHORIZER
    SCYLLADB_AUTHENTICATOR
    SCYLLADB_USER
    SCYLLADB_PASSWORD
    SCYLLADB_KEYSTORE_PASSWORD
    SCYLLADB_TRUSTSTORE_PASSWORD
    SCYLLADB_KEYSTORE_LOCATION
    SCYLLADB_TRUSTSTORE_LOCATION
    SCYLLADB_TMP_P12_FILE
    SCYLLADB_SSL_CERT_FILE
    SCYLLADB_SSL_KEY_FILE
    SCYLLADB_SSL_CA_FILE
    SCYLLADB_SSL_VALIDATE
    SSL_VERSION
    SCYLLADB_CQL_SHARD_PORT_NUMBER
    SCYLLADB_API_PORT_NUMBER
    SCYLLADB_PROMETHEUS_PORT_NUMBER
    SCYLLADB_DEVELOPER_MODE
    SCYLLADB_RUN_JMX_PROXY
)
for env_var in "${scylladb_env_vars[@]}"; do
    file_env_var="${env_var}_FILE"
    if [[ -n "${!file_env_var:-}" ]]; then
        if [[ -r "${!file_env_var:-}" ]]; then
            export "${env_var}=$(< "${!file_env_var}")"
            unset "${file_env_var}"
        else
            warn "Skipping export of '${env_var}'. '${!file_env_var:-}' is not readable."
        fi
    fi
done
unset scylladb_env_vars
export DB_FLAVOR="scylladb"

# Paths
export SCYLLADB_BASE_DIR="/opt/bitnami/scylladb"
export DB_BASE_DIR="$SCYLLADB_BASE_DIR"
export SCYLLADB_BIN_DIR="${DB_BASE_DIR}/bin"
export DB_BIN_DIR="$SCYLLADB_BIN_DIR"
export SCYLLADB_VOLUME_DIR="/bitnami/scylladb"
export DB_VOLUME_DIR="$SCYLLADB_VOLUME_DIR"
export SCYLLADB_DATA_DIR="${DB_VOLUME_DIR}/data"
export DB_DATA_DIR="$SCYLLADB_DATA_DIR"
export SCYLLADB_COMMITLOG_DIR="${DB_DATA_DIR}/commitlog"
export DB_COMMITLOG_DIR="$SCYLLADB_COMMITLOG_DIR"
export SCYLLADB_INITSCRIPTS_DIR="/docker-entrypoint-initdb.d"
export DB_INITSCRIPTS_DIR="$SCYLLADB_INITSCRIPTS_DIR"
export SCYLLADB_LOG_DIR="${DB_BASE_DIR}/logs"
export DB_LOG_DIR="$SCYLLADB_LOG_DIR"
export SCYLLADB_MOUNTED_CONF_DIR="${SCYLLADB_MOUNTED_CONF_DIR:-${DB_VOLUME_DIR}/conf}"
export DB_MOUNTED_CONF_DIR="$SCYLLADB_MOUNTED_CONF_DIR"
export SCYLLADB_TMP_DIR="${DB_BASE_DIR}/tmp"
export DB_TMP_DIR="$SCYLLADB_TMP_DIR"
export JAVA_BASE_DIR="${BITNAMI_ROOT_DIR}/java"
export JAVA_BIN_DIR="${JAVA_BASE_DIR}/bin"
export PYTHON_BASE_DIR="${BITNAMI_ROOT_DIR}/python"
export PYTHON_BIN_DIR="${PYTHON_BASE_DIR}/bin"
export SCYLLADB_LOG_FILE="${DB_LOG_DIR}/scylladb.log"
export DB_LOG_FILE="$SCYLLADB_LOG_FILE"
export SCYLLADB_FIRST_BOOT_LOG_FILE="${DB_LOG_DIR}/scylladb_first_boot.log"
export DB_FIRST_BOOT_LOG_FILE="$SCYLLADB_FIRST_BOOT_LOG_FILE"
export SCYLLADB_INITSCRIPTS_BOOT_LOG_FILE="${DB_LOG_DIR}/scylladb_init_scripts_boot.log"
export DB_INITSCRIPTS_BOOT_LOG_FILE="$SCYLLADB_INITSCRIPTS_BOOT_LOG_FILE"
export SCYLLADB_PID_FILE="${DB_TMP_DIR}/scylladb.pid"
export DB_PID_FILE="$SCYLLADB_PID_FILE"
export PATH="${DB_BIN_DIR}:${BITNAMI_ROOT_DIR}/common/bin:${BITNAMI_ROOT_DIR}/python/bin:${BITNAMI_ROOT_DIR}/java/bin:$PATH"

# System users (when running with a privileged user)
export SCYLLADB_DAEMON_USER="scylladb"
export DB_DAEMON_USER="$SCYLLADB_DAEMON_USER"
export SCYLLADB_DAEMON_GROUP="scylladb"
export DB_DAEMON_GROUP="$SCYLLADB_DAEMON_GROUP"

# ScyllaDB cluster settings
export SCYLLADB_CLIENT_ENCRYPTION="${SCYLLADB_CLIENT_ENCRYPTION:-false}"
export DB_CLIENT_ENCRYPTION="$SCYLLADB_CLIENT_ENCRYPTION"
export SCYLLADB_CLUSTER_NAME="${SCYLLADB_CLUSTER_NAME:-My Cluster}"
export DB_CLUSTER_NAME="$SCYLLADB_CLUSTER_NAME"
export SCYLLADB_DATACENTER="${SCYLLADB_DATACENTER:-dc1}"
export DB_DATACENTER="$SCYLLADB_DATACENTER"
export SCYLLADB_ENABLE_REMOTE_CONNECTIONS="${SCYLLADB_ENABLE_REMOTE_CONNECTIONS:-true}"
export DB_ENABLE_REMOTE_CONNECTIONS="$SCYLLADB_ENABLE_REMOTE_CONNECTIONS"
export SCYLLADB_ENABLE_RPC="${SCYLLADB_ENABLE_RPC:-false}"
export DB_ENABLE_RPC="$SCYLLADB_ENABLE_RPC"
export SCYLLADB_ENABLE_USER_DEFINED_FUNCTIONS="${SCYLLADB_ENABLE_USER_DEFINED_FUNCTIONS:-false}"
export DB_ENABLE_USER_DEFINED_FUNCTIONS="$SCYLLADB_ENABLE_USER_DEFINED_FUNCTIONS"
export SCYLLADB_ENABLE_SCRIPTED_USER_DEFINED_FUNCTIONS="${SCYLLADB_ENABLE_SCRIPTED_USER_DEFINED_FUNCTIONS:-false}"
export DB_ENABLE_SCRIPTED_USER_DEFINED_FUNCTIONS="$SCYLLADB_ENABLE_SCRIPTED_USER_DEFINED_FUNCTIONS"
export SCYLLADB_ENDPOINT_SNITCH="${SCYLLADB_ENDPOINT_SNITCH:-SimpleSnitch}"
export DB_ENDPOINT_SNITCH="$SCYLLADB_ENDPOINT_SNITCH"
export SCYLLADB_HOST="${SCYLLADB_HOST:-}"
export DB_HOST="$SCYLLADB_HOST"
export SCYLLADB_INTERNODE_ENCRYPTION="${SCYLLADB_INTERNODE_ENCRYPTION:-none}"
export DB_INTERNODE_ENCRYPTION="$SCYLLADB_INTERNODE_ENCRYPTION"
export SCYLLADB_NUM_TOKENS="${SCYLLADB_NUM_TOKENS:-256}"
export DB_NUM_TOKENS="$SCYLLADB_NUM_TOKENS"
export SCYLLADB_PASSWORD_SEEDER="${SCYLLADB_PASSWORD_SEEDER:-no}"
export DB_PASSWORD_SEEDER="$SCYLLADB_PASSWORD_SEEDER"
export SCYLLADB_SEEDS="${SCYLLADB_SEEDS:-$DB_HOST}"
export DB_SEEDS="$SCYLLADB_SEEDS"
export SCYLLADB_PEERS="${SCYLLADB_PEERS:-$DB_SEEDS}"
export DB_PEERS="$SCYLLADB_PEERS"
export SCYLLADB_NODES="${SCYLLADB_NODES:-}"
export DB_NODES="$SCYLLADB_NODES"
export SCYLLADB_RACK="${SCYLLADB_RACK:-rack1}"
export DB_RACK="$SCYLLADB_RACK"
export SCYLLADB_BROADCAST_ADDRESS="${SCYLLADB_BROADCAST_ADDRESS:-}"
export DB_BROADCAST_ADDRESS="$SCYLLADB_BROADCAST_ADDRESS"
export SCYLLADB_AUTOMATIC_SSTABLE_UPGRADE="${SCYLLADB_AUTOMATIC_SSTABLE_UPGRADE:-false}"
export DB_AUTOMATIC_SSTABLE_UPGRADE="$SCYLLADB_AUTOMATIC_SSTABLE_UPGRADE"

# Database initialization settings
export SCYLLADB_STARTUP_CQL="${SCYLLADB_STARTUP_CQL:-}"
export DB_STARTUP_CQL="$SCYLLADB_STARTUP_CQL"
export SCYLLADB_IGNORE_INITDB_SCRIPTS="${SCYLLADB_IGNORE_INITDB_SCRIPTS:-no}"
export DB_IGNORE_INITDB_SCRIPTS="$SCYLLADB_IGNORE_INITDB_SCRIPTS"

# Port configuration
export SCYLLADB_CQL_PORT_NUMBER="${SCYLLADB_CQL_PORT_NUMBER:-9042}"
export DB_CQL_PORT_NUMBER="$SCYLLADB_CQL_PORT_NUMBER"
export SCYLLADB_JMX_PORT_NUMBER="${SCYLLADB_JMX_PORT_NUMBER:-7199}"
export DB_JMX_PORT_NUMBER="$SCYLLADB_JMX_PORT_NUMBER"
export SCYLLADB_TRANSPORT_PORT_NUMBER="${SCYLLADB_TRANSPORT_PORT_NUMBER:-7000}"
export DB_TRANSPORT_PORT_NUMBER="$SCYLLADB_TRANSPORT_PORT_NUMBER"

# Retries and sleep time configuration
export SCYLLADB_CQL_MAX_RETRIES="${SCYLLADB_CQL_MAX_RETRIES:-20}"
export DB_CQL_MAX_RETRIES="$SCYLLADB_CQL_MAX_RETRIES"
export SCYLLADB_CQL_SLEEP_TIME="${SCYLLADB_CQL_SLEEP_TIME:-5}"
export DB_CQL_SLEEP_TIME="$SCYLLADB_CQL_SLEEP_TIME"
export SCYLLADB_INIT_MAX_RETRIES="${SCYLLADB_INIT_MAX_RETRIES:-100}"
export DB_INIT_MAX_RETRIES="$SCYLLADB_INIT_MAX_RETRIES"
export SCYLLADB_INIT_SLEEP_TIME="${SCYLLADB_INIT_SLEEP_TIME:-5}"
export DB_INIT_SLEEP_TIME="$SCYLLADB_INIT_SLEEP_TIME"
export SCYLLADB_PEER_CQL_MAX_RETRIES="${SCYLLADB_PEER_CQL_MAX_RETRIES:-100}"
export DB_PEER_CQL_MAX_RETRIES="$SCYLLADB_PEER_CQL_MAX_RETRIES"
export SCYLLADB_PEER_CQL_SLEEP_TIME="${SCYLLADB_PEER_CQL_SLEEP_TIME:-10}"
export DB_PEER_CQL_SLEEP_TIME="$SCYLLADB_PEER_CQL_SLEEP_TIME"
export SCYLLADB_DELAY_START_TIME="${SCYLLADB_DELAY_START_TIME:-10}"
export DB_DELAY_START_TIME="$SCYLLADB_DELAY_START_TIME"

# Snapshot settings
export SCYLLADB_AUTO_SNAPSHOT_TTL="${SCYLLADB_AUTO_SNAPSHOT_TTL:-30d}"
export DB_AUTO_SNAPSHOT_TTL="$SCYLLADB_AUTO_SNAPSHOT_TTL"

# Authentication, Authorization and Credentials
export ALLOW_EMPTY_PASSWORD="${ALLOW_EMPTY_PASSWORD:-no}"
export SCYLLADB_AUTHORIZER="${SCYLLADB_AUTHORIZER:-CassandraAuthorizer}"
export DB_AUTHORIZER="$SCYLLADB_AUTHORIZER"
export SCYLLADB_AUTHENTICATOR="${SCYLLADB_AUTHENTICATOR:-PasswordAuthenticator}"
export DB_AUTHENTICATOR="$SCYLLADB_AUTHENTICATOR"
export SCYLLADB_USER="${SCYLLADB_USER:-cassandra}"
export DB_USER="$SCYLLADB_USER"
export SCYLLADB_PASSWORD="${SCYLLADB_PASSWORD:-}"
export DB_PASSWORD="$SCYLLADB_PASSWORD"
export SCYLLADB_KEYSTORE_PASSWORD="${SCYLLADB_KEYSTORE_PASSWORD:-cassandra}"
export DB_KEYSTORE_PASSWORD="$SCYLLADB_KEYSTORE_PASSWORD"
export SCYLLADB_TRUSTSTORE_PASSWORD="${SCYLLADB_TRUSTSTORE_PASSWORD:-cassandra}"
export DB_TRUSTSTORE_PASSWORD="$SCYLLADB_TRUSTSTORE_PASSWORD"
export SCYLLADB_KEYSTORE_LOCATION="${SCYLLADB_KEYSTORE_LOCATION:-${DB_VOLUME_DIR}/secrets/keystore}"
export DB_KEYSTORE_LOCATION="$SCYLLADB_KEYSTORE_LOCATION"
export SCYLLADB_TRUSTSTORE_LOCATION="${SCYLLADB_TRUSTSTORE_LOCATION:-${DB_VOLUME_DIR}/secrets/truststore}"
export DB_TRUSTSTORE_LOCATION="$SCYLLADB_TRUSTSTORE_LOCATION"
export SCYLLADB_TMP_P12_FILE="${SCYLLADB_TMP_P12_FILE:-${DB_TMP_DIR}/keystore.p12}"
export DB_TMP_P12_FILE="$SCYLLADB_TMP_P12_FILE"
export SCYLLADB_SSL_CERT_FILE="${SCYLLADB_SSL_CERT_FILE:-${DB_VOLUME_DIR}/certs/tls.crt}"
export DB_SSL_CERT_FILE="$SCYLLADB_SSL_CERT_FILE"
export SSL_CERTFILE="$SCYLLADB_SSL_CERT_FILE"
export SCYLLADB_SSL_KEY_FILE="${SCYLLADB_SSL_KEY_FILE:-${DB_VOLUME_DIR}/certs/tls.key}"
export DB_SSL_KEY_FILE="$SCYLLADB_SSL_KEY_FILE"
export SSL_KEYFILE="$SCYLLADB_SSL_KEY_FILE"
export SCYLLADB_SSL_CA_FILE="${SCYLLADB_SSL_CA_FILE:-}"
export DB_SSL_CA_FILE="$SCYLLADB_SSL_CA_FILE"
export SSL_CAFILE="$SCYLLADB_SSL_CA_FILE"
export SCYLLADB_SSL_VALIDATE="${SCYLLADB_SSL_VALIDATE:-false}"
export DB_SSL_VALIDATE="$SCYLLADB_SSL_VALIDATE"
export SSL_VALIDATE="$SCYLLADB_SSL_VALIDATE"

# cqlsh settings
export SSL_VERSION="${SSL_VERSION:-TLSv1_2}"

# Configuration paths
export SCYLLADB_CONF_DIR="${DB_BASE_DIR}/etc"
export SCYLLADB_CONF="$SCYLLADB_CONF_DIR"
export DB_CONF_DIR="$SCYLLADB_CONF_DIR"
export SCYLLADB_DEFAULT_CONF_DIR="${DB_BASE_DIR}/etc.default"
export DB_DEFAULT_CONF_DIR="$SCYLLADB_DEFAULT_CONF_DIR"
export SCYLLADB_CONF_FILE="${DB_CONF_DIR}/scylla/scylla.yaml"
export DB_CONF_FILE="$SCYLLADB_CONF_FILE"
export SCYLLADB_RACKDC_FILE="${DB_CONF_DIR}/scylla/cassandra-rackdc.properties"
export DB_RACKDC_FILE="$SCYLLADB_RACKDC_FILE"
export SCYLLADB_LOGBACK_FILE="${DB_CONF_DIR}/scylla/cassandra/logback.xml"
export DB_LOGBACK_FILE="$SCYLLADB_LOGBACK_FILE"
export SCYLLADB_COMMITLOG_ARCHIVING_FILE="${DB_CONF_DIR}/scylla/cassandra/commitlog_archiving.properties"
export DB_COMMITLOG_ARCHIVING_FILE="$SCYLLADB_COMMITLOG_ARCHIVING_FILE"
export SCYLLADB_ENV_FILE="${DB_CONF_DIR}/scylla/cassandra/cassandra-env.sh"
export DB_ENV_FILE="$SCYLLADB_ENV_FILE"
export SCYLLADB_MOUNTED_CONF_PATH="scylla/scylla.yaml"
export DB_MOUNTED_CONF_PATH="$SCYLLADB_MOUNTED_CONF_PATH"
export SCYLLADB_MOUNTED_RACKDC_PATH="scylla/cassandra-rackdc.properties"
export DB_MOUNTED_RACKDC_PATH="$SCYLLADB_MOUNTED_RACKDC_PATH"
export SCYLLADB_MOUNTED_ENV_PATH="scylla/cassandra/cassandra-env.sh"
export DB_MOUNTED_ENV_PATH="$SCYLLADB_MOUNTED_ENV_PATH"
export SCYLLADB_MOUNTED_LOGBACK_PATH="scylla/cassandra/logback.xml"
export DB_MOUNTED_LOGBACK_PATH="$SCYLLADB_MOUNTED_LOGBACK_PATH"

# ScyllaDB specific settings
export SCYLLADB_CQL_SHARD_PORT_NUMBER="${SCYLLADB_CQL_SHARD_PORT_NUMBER:-19042}"
export SCYLLADB_API_PORT_NUMBER="${SCYLLADB_API_PORT_NUMBER:-10000}"
export SCYLLADB_PROMETHEUS_PORT_NUMBER="${SCYLLADB_PROMETHEUS_PORT_NUMBER:-9180}"
export SCYLLADB_DEVELOPER_MODE="${SCYLLADB_DEVELOPER_MODE:-yes}"
export SCYLLADB_RUN_JMX_PROXY="${SCYLLADB_RUN_JMX_PROXY:-no}"

# Custom environment variables may be defined below
