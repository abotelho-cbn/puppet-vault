# Reference

<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

### Classes

* [`vault`](#vault): Install & configure a Vault server or Vault Agent
* [`vault::config`](#vaultconfig): Set the Vault config via JSON file & optionally set up a system service
* [`vault::install`](#vaultinstall): Install Vault, either from a repository or archive
* [`vault::params`](#vaultparams): Parameters for the `vault` class.
It sets variables according to platform.
* [`vault::service`](#vaultservice): Manage the Vault system service, enabled by default

## Classes

### <a name="vault"></a>`vault`

Install & configure a Vault server or Vault Agent

#### Examples

##### Basic usage

```puppet
include vault
```

##### Specify a version

```puppet
class { 'vault':
  version => '1.11.1',
}
```

#### Parameters

The following parameters are available in the `vault` class:

* [`user`](#user)
* [`manage_user`](#manage_user)
* [`group`](#group)
* [`manage_group`](#manage_group)
* [`bin_dir`](#bin_dir)
* [`config_dir`](#config_dir)
* [`config_mode`](#config_mode)
* [`manage_config_file`](#manage_config_file)
* [`purge_config_dir`](#purge_config_dir)
* [`download_url`](#download_url)
* [`download_url_base`](#download_url_base)
* [`download_extension`](#download_extension)
* [`service_name`](#service_name)
* [`service_enable`](#service_enable)
* [`service_ensure`](#service_ensure)
* [`service_provider`](#service_provider)
* [`service_type`](#service_type)
* [`service_options`](#service_options)
* [`manage_repo`](#manage_repo)
* [`manage_service`](#manage_service)
* [`manage_service_file`](#manage_service_file)
* [`storage`](#storage)
* [`manage_storage_dir`](#manage_storage_dir)
* [`listener`](#listener)
* [`ha_storage`](#ha_storage)
* [`seal`](#seal)
* [`disable_cache`](#disable_cache)
* [`telemetry`](#telemetry)
* [`default_lease_ttl`](#default_lease_ttl)
* [`max_lease_ttl`](#max_lease_ttl)
* [`disable_mlock`](#disable_mlock)
* [`manage_file_capabilities`](#manage_file_capabilities)
* [`num_procs`](#num_procs)
* [`install_method`](#install_method)
* [`package_name`](#package_name)
* [`package_ensure`](#package_ensure)
* [`download_dir`](#download_dir)
* [`manage_download_dir`](#manage_download_dir)
* [`download_filename`](#download_filename)
* [`version`](#version)
* [`os`](#os)
* [`arch`](#arch)
* [`enable_ui`](#enable_ui)
* [`api_addr`](#api_addr)
* [`extra_config`](#extra_config)

##### <a name="user"></a>`user`

Data type: `String`

Customise the user vault runs as, will also create the user unless `manage_user` is false.

Default value: `$vault::params::user`

##### <a name="manage_user"></a>`manage_user`

Data type: `Boolean`

Whether or not the module should create the user.

Default value: `$vault::params::manage_user`

##### <a name="group"></a>`group`

Data type: `String`

Customise the group vault runs as, will also create the user unless `manage_group` is false.

Default value: `$vault::params::group`

##### <a name="manage_group"></a>`manage_group`

Data type: `Boolean`

Whether or not the module should create the group.

Default value: `$vault::params::manage_group`

##### <a name="bin_dir"></a>`bin_dir`

Data type: `String`

Directory the vault executable will be installed in.

Default value: `$vault::params::bin_dir`

##### <a name="config_dir"></a>`config_dir`

Data type: `String`

Directory the vault configuration will be kept in.

Default value: `$vault::params::config_dir`

##### <a name="config_mode"></a>`config_mode`

Data type: `String`

Mode of the configuration file (config.json). Defaults to '0750'

Default value: `$vault::params::config_mode`

##### <a name="manage_config_file"></a>`manage_config_file`

Data type: `Boolean`

Whether the `config_file` should be managed

Default value: `$vault::params::manage_config_file`

##### <a name="purge_config_dir"></a>`purge_config_dir`

Data type: `Boolean`

Whether the `config_dir` should be purged before installing the
generated config.

Default value: ``true``

##### <a name="download_url"></a>`download_url`

Data type: `Optional[String]`

Manual URL to download the vault zip distribution from.

Default value: `$vault::params::download_url`

##### <a name="download_url_base"></a>`download_url_base`

Data type: `String`

HashiCorp base URL to download vault zip distribution from.

Default value: `$vault::params::download_url_base`

##### <a name="download_extension"></a>`download_extension`

Data type: `String`

The extension of the vault download

Default value: `$vault::params::download_extension`

##### <a name="service_name"></a>`service_name`

Data type: `String`

Customise the name of the system service

Default value: `$vault::params::service_name`

##### <a name="service_enable"></a>`service_enable`

Data type: `Boolean`

Set the `enable` value for `service[$service_name]`

Default value: `$vault::params::service_enable`

##### <a name="service_ensure"></a>`service_ensure`

Data type: `String`

Set the `ensure` value for `service[$service_name]`

Default value: `$vault::params::service_ensure`

##### <a name="service_provider"></a>`service_provider`

Data type: `String`

Customise the name of the system service provider; this
also controls the init configuration files that are installed.

Default value: `$vault::params::service_provider`

##### <a name="service_type"></a>`service_type`

Data type: `String`

Choose between `server` or `agent` for which mode you want the
Vault binary to run as.

Default value: `$vault::params::service_type`

##### <a name="service_options"></a>`service_options`

Data type: `Optional[String]`

Additional arguments or options, passed directly to the command run by the service

Default value: `$vault::params::service_options`

##### <a name="manage_repo"></a>`manage_repo`

Data type: `Boolean`

Configure the upstream HashiCorp repository. Only relevant when $nomad::install_method = 'repo'.

Default value: `$vault::params::manage_repo`

##### <a name="manage_service"></a>`manage_service`

Data type: `Boolean`

Instruct puppet to manage service or not

Default value: `$vault::params::manage_service`

##### <a name="manage_service_file"></a>`manage_service_file`

Data type: `Optional[Boolean]`

Whether to override the per-install-method management of the service file

Default value: `$vault::params::manage_service_file`

##### <a name="storage"></a>`storage`

Data type: `Hash`

Hash representation of the `storage` Vault config stanza

Default value: `$vault::params::storage`

##### <a name="manage_storage_dir"></a>`manage_storage_dir`

Data type: `Boolean`

Whether or not the directory for storing data is managed by this module
If manage_storage_dir is true and a file or raft storage backend is
configured, we create the directory configured in that backend.

Default value: `$vault::params::manage_storage_dir`

##### <a name="listener"></a>`listener`

Data type: `Variant[Hash, Array[Hash]]`

Hash representation of the `listener` Vault config stanza

Default value: `$vault::params::listener`

##### <a name="ha_storage"></a>`ha_storage`

Data type: `Optional[Hash]`

Hash representation of the `ha_storage` Vault config stanza

Default value: `$vault::params::ha_storage`

##### <a name="seal"></a>`seal`

Data type: `Optional[Hash]`

Hash representation of the `seal` Vault config stanza

Default value: `$vault::params::seal`

##### <a name="disable_cache"></a>`disable_cache`

Data type: `Optional[Boolean]`

Sets the `disable_cache` Vault config value

Default value: `$vault::params::disable_cache`

##### <a name="telemetry"></a>`telemetry`

Data type: `Optional[Hash]`

Hash representation of the `telemetry` Vault config

Default value: `$vault::params::telemetry`

##### <a name="default_lease_ttl"></a>`default_lease_ttl`

Data type: `Optional[String]`

Sets the `default_lease_ttl` Valut config value

Default value: `$vault::params::default_lease_ttl`

##### <a name="max_lease_ttl"></a>`max_lease_ttl`

Data type: `Optional[String]`

Sets the `max_lease_ttl` Valut config value

Default value: `$vault::params::max_lease_ttl`

##### <a name="disable_mlock"></a>`disable_mlock`

Data type: `Optional[Boolean]`

Sets the `disable_mlock` Valut config value

Default value: `$vault::params::disable_mlock`

##### <a name="manage_file_capabilities"></a>`manage_file_capabilities`

Data type: `Optional[Boolean]`

Tightly coupled to `$disable_mlock`, see `vault::install` for details

Default value: `$vault::params::manage_file_capabilities`

##### <a name="num_procs"></a>`num_procs`

Data type: `Integer`

Sets the GOMAXPROCS environment variable, to determine how many CPUs Vault
can use. The official Vault Terraform install.sh script sets this to the
output of ``nprocs``, with the comment, "Make sure to use all our CPUs,
because Vault can block a scheduler thread". Default: number of CPUs
on the system, retrieved from the ``processorcount`` Fact.

Default value: `$vault::params::num_procs`

##### <a name="install_method"></a>`install_method`

Data type: `Enum['archive', 'repo']`

Can be one of `archive` or `repo`
  * `repo` will use a HashiCorp package repository to install Vault
  * `archive` will use a HashiCorp ZIP artifact to install Vault

Default value: `$vault::params::install_method`

##### <a name="package_name"></a>`package_name`

Data type: `String`

The name of the package to install if using `$install_method = 'repo'`

Default value: `$vault::params::package_name`

##### <a name="package_ensure"></a>`package_ensure`

Data type: `String`

Set the `ensure` parameter for a package install if using `$install_method = 'repo'`

Default value: `$vault::params::package_ensure`

##### <a name="download_dir"></a>`download_dir`

Data type: `String`

The directory to download to when using `$install_method = 'archive'`

Default value: `$vault::params::download_dir`

##### <a name="manage_download_dir"></a>`manage_download_dir`

Data type: `Boolean`

Whether or not to create/manage the download directory when using `$install_method = 'archive'`

Default value: `$vault::params::manage_download_dir`

##### <a name="download_filename"></a>`download_filename`

Data type: `String`

The name of the downloaded file when using `$install_method = 'archive'`

Default value: `$vault::params::download_filename`

##### <a name="version"></a>`version`

Data type: `String`

The version of Vault to install

Default value: `$vault::params::version`

##### <a name="os"></a>`os`

Data type: `String`

Override the `$facts['kernel']` supplied OS value

Default value: `$vault::params::os`

##### <a name="arch"></a>`arch`

Data type: `String`

Override the `$facts['os']['architecture']` supplied architecture value

Default value: `$vault::params::arch`

##### <a name="enable_ui"></a>`enable_ui`

Data type: `Optional[Boolean]`

Whether or not to enable the Vault web UI

Default value: `$vault::params::enable_ui`

##### <a name="api_addr"></a>`api_addr`

Data type: `Optional[String]`

Specifies the address (full URL) to advertise to other Vault servers in the
cluster for client redirection. This value is also used for plugin backends.
This can also be provided via the environment variable VAULT_API_ADDR. In
general this should be set as a full URL that points to the value of the
listener address

Default value: ``undef``

##### <a name="extra_config"></a>`extra_config`

Data type: `Hash`

Hash representation of any additional Vault configuration not already represented

Default value: `{}`

### <a name="vaultconfig"></a>`vault::config`

Set the Vault config via JSON file & optionally set up a system service

### <a name="vaultinstall"></a>`vault::install`

Install Vault, either from a repository or archive

### <a name="vaultparams"></a>`vault::params`

Parameters for the `vault` class.
It sets variables according to platform.

### <a name="vaultservice"></a>`vault::service`

Manage the Vault system service, enabled by default
