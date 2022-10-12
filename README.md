[![Puppet Forge](https://img.shields.io/puppetforge/v/jeffbyrnes/vault.svg)](https://forge.puppetlabs.com/jeffbyrnes/vault)
[![Puppet Forge Downloads](https://img.shields.io/puppetforge/dt/jeffbyrnes/vault.svg)](https://forge.puppetlabs.com/jeffbyrnes/vault)

# puppet-vault

Puppet module to install and run [HashiCorp Vault](https://vaultproject.io).

## Support

This module is currently only tested on:

* Ubuntu 18.04
* Ubuntu 20.04
* CentOS/RedHat 7
* CentOS/RedHat 8

## Usage

```puppet
include vault
```

By default, with no parameters the module will configure Vault with some sensible defaults to get you running. Please see [Vault’s official config docs](https://www.vaultproject.io/docs/configuration/index.html) for further details of acceptable parameter values.

## Parameters

Full documentation of the module’s parameters can be found in [DOCS.md](https://github.com/athenahealth/puppet-vault/blob/main/DOCS.md).

However, we highlight some important details below.

### Installation parameters

#### When `install_method` is `repo`

When `repo` is set the module will attempt to install a package corresponding with the value of `package_name`.

* `package_name`:  Name of the package to install, default: `vault`
* `package_ensure`: Desired state of the package, default: `installed`
* `bin_dir`: Set to the path where the package will install the Vault binary, this is necessary to correctly manage the [`disable_mlock`](#mlock) option.
* `manage_service_file`: Will manage the service file in case it's not included in the package, default: false
* `manage_file_capabilities`: Will manage file capabilities of the vault binary. default: `false`

#### When `install_method` is `archive`

When `archive` the module will attempt to download and extract a zip file from the `download_url`, the extracted file will be placed in the `bin_dir` folder.

The module will **not** manage any required packages to un-archive, e.g. `unzip`. See [`puppet-archive` setup](https://github.com/voxpupuli/puppet-archive#setup) documentation for more details.

* `download_url`: Optional manual URL to download the vault zip distribution from.  You can specify a local file on the server with a fully qualified pathname, or use `http`, `https`, `ftp` or `s3` based URIs. default: `undef`
* `download_url_base`: This is the base URL for the hashicorp releases. If no manual `download_url` is specified, the module will download from hashicorp. default: `https://releases.hashicorp.com/vault/`
* `download_extension`: The extension of the vault download when using hashicorp releases. default: `zip`
* `download_dir`: Path to download the zip file to, default: `/tmp`
* `manage_download_dir`: Boolean, whether or not to create the download directory, default: `false`
* `download_filename`: Filename to (temporarily) save the downloaded zip file, default: `vault.zip`
* `version`: The Version of vault to download. default: `1.4.2`
* `manage_service_file`: Will manage the service file. default: true
* `manage_file_capabilities`: Will manage file capabilities of the vault binary. default: `true`

### Configuration parameters

By default, with no parameters the module will configure Vault with some sensible defaults to get you running.  Please see [Vault’s official config docs](https://www.vaultproject.io/docs/configuration/index.html) for further details of acceptable parameter values.

* `storage`: A hash containing the Vault storage configuration. File and raft storage backends are supported. In the examples section you can find an example for raft. The file backend is the default:

    ```puppet
    { 'file' => { 'path' => '/var/lib/vault' } }
    ```

* `listener`: A hash or array of hashes containing the listener configuration(s), default:

    ```puppet
    {
      'tcp' => {
        'address'     => '127.0.0.1:8200',
        'tls_disable' => 1,
      }
    }
    ```

* `ha_storage`: An optional hash containing the `ha_storage` configuration
* `seal`: An optional hash containing the `seal` configuration
* `telemetry`: An optional hash containing the `telemetry` configuration
* `disable_cache`: A boolean to disable or enable the cache (default: `undef`)
* `disable_mlock`: A boolean to disable or enable mlock [See below](#mlock) (default: `undef`)
* `default_lease_ttl`: A string containing the default lease TTL (default: `undef`)
* `max_lease_ttl`: A string containing the max lease TTL (default: `undef`)
* `enable_ui`: Enable the vault UI (requires vault 0.10.0+ or Enterprise) (default: `undef`)
* `api_addr`: Specifies the address (full URL) to advertise to other Vault servers in the cluster for client redirection. This value is also used for plugin backends. This can also be provided via the environment variable VAULT_API_ADDR. In general this should be set as a full URL that points to the value of the listener address (default: `undef`)
* `extra_config`: A hash containing extra configuration, intended for newly released configuration not yet supported by the module. This hash will get merged with other configuration attributes into the JSON config file.

## Examples

```puppet
class { 'vault':
  storage => {
    file => {
      path => '/tmp',
    },
  },
  listener => [
    {
      tcp => {
        address     => '127.0.0.1:8200',
        tls_disable => 0,
      }
    },
    {
      tcp => {
        address => '10.0.0.10:8200',
      }
    },
  ]
}
```

or alternatively, using Hiera:

```yaml
vault::storage:
  file:
    path: /tmp

vault::listener:
  - tcp:
      address: 127.0.0.1:8200
      tls_disable: 1
  - tcp:
      address: 10.0.0.10:8200

vault::default_lease_ttl: 720h
```

Configuring raft storage engine using Hiera:

```yaml
vault::storage:
  raft:
    node_id: '%{facts.networking.hostname}'
    path: /var/lib/vault
    retry_join:
    - leader_api_addr: https://vault1:8200
    - leader_api_addr: https://vault2:8200
    - leader_api_addr: https://vault3:8200
```

## `mlock`

By default Vault will use the `mlock` system call, therefore the executable will need the corresponding capability.

In production, you should only consider setting the `disable_mlock` option on Linux systems that only use encrypted swap or do not use swap at all.

The module will use `setcap` on the vault binary to enable this.

If you do not wish to use `mlock`, set the `disable_mlock` attribute to `true`

```puppet
class { 'vault':
  disable_mlock => true,
}
```

## Testing

If you’re using PDK, run every test with `pdk validate`

First, `bundle install`

To run RSpec unit tests: `bundle exec rake spec`

To run RSpec unit tests, puppet-lint, syntax checks and metadata lint: `bundle exec rake test`

To run Beaker acceptance tests: `BEAKER_set=<nodeset name> bundle exec rake acceptance` where `<nodeset name>` is one of the filenames in `spec/acceptance/nodesets` without the trailing `.yml`, e.g. `ubuntu-20.04-x86_64-docker`.

## Related Projects

* [`hiera-vault`](https://github.com/jsok/hiera-vault): A Hiera storage backend to retrieve secrets from HashiCorp's Vault
