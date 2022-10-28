# @summary Install & configure a Vault server or Vault Agent
#
# @example Basic usage
#   include vault
#
# @example Specify a version
#   class { 'vault':
#     version => '1.11.1',
#   }
#
# @param user
#   Customise the user vault runs as, will also create the user unless `manage_user` is false.
#
# @param manage_user
#   Whether or not the module should create the user.
#
# @param group
#   Customise the group vault runs as, will also create the user unless `manage_group` is false.
#
# @param manage_group
#   Whether or not the module should create the group.
#
# @param bin_dir
#   Directory the vault executable will be installed in.
#
# @param config_dir
#   Directory the vault configuration will be kept in.
#
# @param config_mode
#   Mode of the configuration file (config.json). Defaults to '0750'
#
# @param manage_config_file
#   Whether the `config_file` should be managed
#
# @param purge_config_dir
#   Whether the `config_dir` should be purged before installing the
#   generated config.
#
# @param download_url
#   Manual URL to download the vault zip distribution from.
#
# @param download_url_base
#   HashiCorp base URL to download vault zip distribution from.
#
# @param download_extension
#   The extension of the vault download
#
# @param service_name
#   Customise the name of the system service
#
# @param service_enable
#   Set the `enable` value for `service[$service_name]`
#
# @param service_ensure
#   Set the `ensure` value for `service[$service_name]`
#
# @param service_provider
#   Customise the name of the system service provider; this
#   also controls the init configuration files that are installed.
#
# @param service_type
#   Choose between `server` or `agent` for which mode you want the
#   Vault binary to run as.
#
# @param service_options
#   Additional arguments or options, passed directly to the command run by the service
#
# @param manage_repo
#   Configure the upstream HashiCorp repository. Only relevant when $vault::install_method = 'repo'.
#
# @param manage_service
#   Instruct puppet to manage service or not
#
# @param manage_service_file
#   Whether to override the per-install-method management of the service file
#
# @param storage
#   Hash representation of the `storage` Vault config stanza
#
# @param manage_storage_dir
#   Whether or not the directory for storing data is managed by this module
#   If manage_storage_dir is true and a file or raft storage backend is
#   configured, we create the directory configured in that backend.
#
# @param listener
#   Hash representation of the `listener` Vault config stanza
#
# @param ha_storage
#   Hash representation of the `ha_storage` Vault config stanza
#
# @param seal
#   Hash representation of the `seal` Vault config stanza
#
# @param disable_cache
#   Sets the `disable_cache` Vault config value
#
# @param telemetry
#   Hash representation of the `telemetry` Vault config
#
# @param default_lease_ttl
#   Sets the `default_lease_ttl` Valut config value
#
# @param max_lease_ttl
#   Sets the `max_lease_ttl` Valut config value
#
# @param disable_mlock
#   Sets the `disable_mlock` Valut config value
#
# @param manage_file_capabilities
#   Tightly coupled to `$disable_mlock`, see `vault::install` for details
#
# @param num_procs
#   Sets the `GOMAXPROCS` environment variable, to determine how many CPUs Vault
#   can use. The official Vault Terraform install.sh script sets this to the
#   output of `nprocs`, with the comment, "Make sure to use all our CPUs,
#   because Vault can block a scheduler thread". Default: number of CPUs
#   on the system.
#
# @param install_method
#   Can be one of `archive` or `repo`
#     * `repo` will use a HashiCorp package repository to install Vault
#     * `archive` will use a HashiCorp ZIP artifact to install Vault
#
# @param package_name
#   The name of the package to install if using `$install_method = 'repo'`
#
# @param package_ensure
#   Set the `ensure` parameter for a package install if using `$install_method = 'repo'`
#
# @param download_dir
#   The directory to download to when using `$install_method = 'archive'`
#
# @param manage_download_dir
#   Whether or not to create/manage the download directory when using `$install_method = 'archive'`
#
# @param download_filename
#   The name of the downloaded file when using `$install_method = 'archive'`
#
# @param version
#   The version of Vault to install
#
# @param os_type
#   Override the `$facts['kernel']` supplied OS value (e.g., 'Linux')
#
# @param arch
#   Override the `$facts['os']['architecture']` supplied architecture value
#
# @param enable_ui
#   Whether or not to enable the Vault web UI
#
# @param api_addr
#   Specifies the address (full URL) to advertise to other Vault servers in the
#   cluster for client redirection. This value is also used for plugin backends.
#   This can also be provided via the environment variable VAULT_API_ADDR. In
#   general this should be set as a full URL that points to the value of the
#   listener address
#
# @param extra_config
#   Hash representation of any additional Vault configuration not already represented
#
class vault (
  String   $user                              = $vault::params::user,
  Boolean  $manage_user                       = $vault::params::manage_user,
  String   $group                             = $vault::params::group,
  Boolean  $manage_group                      = $vault::params::manage_group,
  String   $bin_dir                           = $vault::params::bin_dir,
  String   $config_dir                        = $vault::params::config_dir,
  String   $config_mode                       = $vault::params::config_mode,
  Boolean  $manage_config_file                = $vault::params::manage_config_file,
  Boolean  $purge_config_dir                  = true,
  Optional[String] $download_url              = $vault::params::download_url,
  String   $download_url_base                 = $vault::params::download_url_base,
  String   $download_extension                = $vault::params::download_extension,
  String   $service_name                      = $vault::params::service_name,
  Boolean  $service_enable                    = $vault::params::service_enable,
  String   $service_ensure                    = $vault::params::service_ensure,
  String   $service_provider                  = $vault::params::service_provider,
  String   $service_type                      = $vault::params::service_type,
  Optional[String] $service_options           = $vault::params::service_options,
  Boolean  $manage_repo                       = $vault::params::manage_repo,
  Boolean  $manage_service                    = $vault::params::manage_service,
  Optional[Boolean] $manage_service_file      = $vault::params::manage_service_file,
  Hash     $storage                           = $vault::params::storage,
  Boolean  $manage_storage_dir                = $vault::params::manage_storage_dir,
  Variant[Hash, Array[Hash]] $listener        = $vault::params::listener,
  Optional[Hash] $ha_storage                  = $vault::params::ha_storage,
  Optional[Hash] $seal                        = $vault::params::seal,
  Optional[Boolean] $disable_cache            = $vault::params::disable_cache,
  Optional[Hash] $telemetry                   = $vault::params::telemetry,
  Optional[String] $default_lease_ttl         = $vault::params::default_lease_ttl,
  Optional[String] $max_lease_ttl             = $vault::params::max_lease_ttl,
  Optional[Boolean] $disable_mlock            = $vault::params::disable_mlock,
  Optional[Boolean] $manage_file_capabilities = $vault::params::manage_file_capabilities,
  Integer  $num_procs                         = $vault::params::num_procs,
  Enum['archive', 'repo'] $install_method     = $vault::params::install_method,
  String   $package_name                      = $vault::params::package_name,
  String   $package_ensure                    = $vault::params::package_ensure,
  String   $download_dir                      = $vault::params::download_dir,
  Boolean  $manage_download_dir               = $vault::params::manage_download_dir,
  String   $download_filename                 = $vault::params::download_filename,
  String   $version                           = $vault::params::version,
  String   $os_type                           = $vault::params::os_type,
  String   $arch                              = $vault::params::arch,
  Optional[Boolean] $enable_ui                = $vault::params::enable_ui,
  Optional[String] $api_addr                  = undef,
  Hash     $extra_config                      = {},
) inherits vault::params {
  # lint:ignore:140chars
  $real_download_url = pick($download_url, "${download_url_base}${version}/${package_name}_${version}_${os_type}_${arch}.${download_extension}")
  # lint:endignore

  contain vault::install
  contain vault::config
  contain vault::service

  Class['vault::install'] -> Class['vault::config']
  Class['vault::config'] ~> Class['vault::service']
}
