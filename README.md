# kitchen_multi_suites_same_vm

Sample cookbook configuration with multiple test suites executed against the same VM within Test Kitchen.

## Usage

* Execute `kitchen list` to show that there is only a single kitchen suite configured.

```plain
$ kitchen list
Instance          Driver   Provisioner  Verifier  Transport  Last Action    Last Error
install-centos-8  Vagrant  ChefZero     Inspec    Ssh        <Not Created>  <None>
```

* Additional kitchen suites in the kitchen.yml file are wrapped in an ERB `if` block to only render if `.kitchen/install-centos-8.yml` file is present.
* Execute `kitchen create` which will create the initial kitchen instance

```plain
$ kitchen create
-----> Starting Test Kitchen (v2.11.2)
-----> Creating <install-centos-8>...
       Bringing machine 'default' up with 'virtualbox' provider...
       ==> default: Checking if box 'bento/centos-8' version '202012.21.0' is up to date...
       ==> default: Setting the name of the VM: kitchen-kitchen_multi_suites_same_vm-install-centos-8-a3dd806a-045d-4d5a-81a1-1a20fa4994c0
       ==> default: Fixed port collision for 22 => 2222. Now on port 2200.
       ==> default: Clearing any previously set network interfaces...
       ==> default: Preparing network interfaces based on configuration...
           default: Adapter 1: nat
       ==> default: Forwarding ports...
           default: 22 (guest) => 2200 (host) (adapter 1)
       ==> default: Running 'pre-boot' VM customizations...
       ==> default: Booting VM...
       ==> default: Waiting for machine to boot. This may take a few minutes...
           default: SSH address: 127.0.0.1:2200
           default: SSH username: vagrant
           default: SSH auth method: private key
           default:
           default: Vagrant insecure key detected. Vagrant will automatically replace
           default: this with a newly generated keypair for better security.
           default:
           default: Inserting generated public key within guest...
           default: Removing insecure key from the guest if it's present...
           default: Key inserted! Disconnecting and reconnecting using new SSH key...
       ==> default: Machine booted and ready!
       ==> default: Checking for guest additions in VM...
       ==> default: Setting hostname...
       ==> default: Mounting shared folders...
           default: /tmp/omnibus/cache => /Users/myuser/.kitchen/cache
       ==> default: Machine not provisioned because `--no-provision` is specified.
       [SSH] Established
       Vagrant instance <install-centos-8> created.
       Finished creating <install-centos-8> (0m37.22s).
-----> Test Kitchen is finished. (0m38.53s)
```

* `kitchen list` will now show the additional suites which have a dependency on the `install` instance

```plain
$ kitchen list                                                                                                                                                          [10:07:08]
Instance              Driver   Provisioner  Verifier  Transport  Last Action    Last Error
install-centos-8      Vagrant  ChefZero     Inspec    Ssh        Created        <None>
reconfigure-centos-8  Dummy    ChefZero     Inspec    Ssh        <Not Created>  <None>
uninstall-centos-8    Dummy    ChefZero     Inspec    Ssh        <Not Created>  <None>
```

* Execute `kitchen verify` to converge and run all test suites.  `kitchen verify` is explicitly used at this stage so that each instance will converge and then verify in the exact order required.

```plain
$ kitchen verify
-----> Starting Test Kitchen (v2.11.2)
-----> Converging <install-centos-8>...
       Preparing files for transfer
       Installing cookbooks for Policyfile /Users/myuser/dev/tmp/kitchen_multi_suites_same_vm/Policyfile.rb using `/usr/local/bin/chef-cli install`
       Installing cookbooks from lock
       Installing kitchen_multi_suites_same_vm 0.1.0
       Preparing dna.json
       Exporting cookbook dependencies from Policyfile /var/folders/lb/9lk_d_6x6qz3d04r5tfhs_tw0000gp/T/install-centos-8-sandbox-20210525-35851-xfz9f6 using `/usr/local/bin/chef-cli export`...
       Exported policy 'kitchen_multi_suites_same_vm' to /var/folders/lb/9lk_d_6x6qz3d04r5tfhs_tw0000gp/T/install-centos-8-sandbox-20210525-35851-xfz9f6

       To converge this system with the exported policy, run:
         cd /var/folders/lb/9lk_d_6x6qz3d04r5tfhs_tw0000gp/T/install-centos-8-sandbox-20210525-35851-xfz9f6
         chef-client -z
       Removing non-cookbook files before transfer
       Preparing validation.pem
       Preparing client.rb
-----> Installing Chef install only if missing package
       Downloading https://omnitruck.chef.io/install.sh to file /tmp/install.sh
       Trying wget...
       Download complete.
       el 8 x86_64
       Getting information for chef stable  for el...
       downloading https://omnitruck.chef.io/stable/chef/metadata?v=&p=el&pv=8&m=x86_64
         to file /tmp/install.sh.3482/metadata.txt
       trying wget...
       sha1     ddb51a469473e7513b5c540b8bbf2531ceb349a6
       sha256   25007073f6b52254a20c01e7f690d2ca71fdf4624be34cdf76cc80684d362739
       url      https://packages.chef.io/files/stable/chef/17.1.35/el/8/chef-17.1.35-1.el8.x86_64.rpm
       version  17.1.35
       downloaded metadata file looks valid...
       /tmp/omnibus/cache/chef-17.1.35-1.el8.x86_64.rpm exists
       Comparing checksum with sha256sum...

       WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING

       You are installing a package without a version pin.  If you are installing
       on production servers via an automated process this is DANGEROUS and you will
       be upgraded without warning on new releases, even to new major releases.
       Letting the version float is only appropriate in desktop, test, development or
       CI/CD environments.

       WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING

       Installing chef
       installing with rpm...
       warning: /tmp/omnibus/cache/chef-17.1.35-1.el8.x86_64.rpm: Header V4 DSA/SHA1 Signature, key ID 83ef826a: NOKEY
       Verifying...                          ################################# [100%]
       Preparing...                          ################################# [100%]
       Updating / installing...
          1:chef-17.1.35-1.el8               ################################# [100%]
       Thank you for installing Chef Infra Client! For help getting started visit https://learn.chef.io
       Transferring files to <install-centos-8>
       +---------------------------------------------+
       ✔ 2 product licenses accepted.
       +---------------------------------------------+
       Starting Chef Infra Client, version 17.1.35
       Patents: https://www.chef.io/patents
       Creating a new client identity for install-centos-8 using the validator key.
       Using policy 'kitchen_multi_suites_same_vm' at revision 'bed0e262b9bc071b400f25068be0a5f75240f2b07584cb6cc0a666bcb2dc8599'
       resolving cookbooks for run list: ["kitchen_multi_suites_same_vm::default@0.1.0 (60c4895)"]
       Synchronizing Cookbooks:
         - kitchen_multi_suites_same_vm (0.1.0)
       Installing Cookbook Gems:
       Compiling Cookbooks...
       Converging 3 resources
       Recipe: kitchen_multi_suites_same_vm::default
         * log[Running the default recipe] action write
       Recipe: kitchen_multi_suites_same_vm::install
         * log[install] action write
         * file[/tmp/cookbook-run-install] action create
           - create new file /tmp/cookbook-run-install
           - restore selinux security context

       Running handlers:
       Running handlers complete
       Chef Infra Client finished, 1/3 resources updated in 03 seconds
       Downloading files from <install-centos-8>
       Finished converging <install-centos-8> (0m24.25s).
-----> Setting up <install-centos-8>...
       Finished setting up <install-centos-8> (0m0.00s).
-----> Verifying <install-centos-8>...
       Loaded tests from {:path=>".Users.myuser.dev.tmp.kitchen_multi_suites_same_vm.test.integration.default.install_test.rb"}

Profile: tests from {:path=>"/Users/myuser/dev/tmp/kitchen_multi_suites_same_vm/test/integration/default/install_test.rb"} (tests from {:path=>".Users.myuser.dev.tmp.kitchen_multi_suites_same_vm.test.integration.default.install_test.rb"})
Version: (not specified)
Target:  ssh://vagrant@127.0.0.1:2200

  File /tmp/cookbook-run-install
     ✔  is expected to exist

Test Summary: 1 successful, 0 failures, 0 skipped
       Finished verifying <install-centos-8> (0m3.03s).
-----> Creating <reconfigure-centos-8>...
       [Dummy] Create on instance=#<Kitchen::Instance:0x00007f95414ab630> with state={:my_id=>"reconfigure-centos-8-1621957897"}
       Finished creating <reconfigure-centos-8> (0m0.00s).
-----> Converging <reconfigure-centos-8>...
       Preparing files for transfer
       Installing cookbooks for Policyfile /Users/myuser/dev/tmp/kitchen_multi_suites_same_vm/Policyfile.rb using `/usr/local/bin/chef-cli install`
       Installing cookbooks from lock
       Installing kitchen_multi_suites_same_vm 0.1.0
       Preparing dna.json
       Exporting cookbook dependencies from Policyfile /var/folders/lb/9lk_d_6x6qz3d04r5tfhs_tw0000gp/T/reconfigure-centos-8-sandbox-20210525-35851-8bp1xt using `/usr/local/bin/chef-cli export`...
       Exported policy 'kitchen_multi_suites_same_vm' to /var/folders/lb/9lk_d_6x6qz3d04r5tfhs_tw0000gp/T/reconfigure-centos-8-sandbox-20210525-35851-8bp1xt

       To converge this system with the exported policy, run:
         cd /var/folders/lb/9lk_d_6x6qz3d04r5tfhs_tw0000gp/T/reconfigure-centos-8-sandbox-20210525-35851-8bp1xt
         chef-client -z
       Removing non-cookbook files before transfer
       Preparing validation.pem
       Preparing client.rb
-----> Chef installation detected (install only if missing)
       Transferring files to <reconfigure-centos-8>
       Starting Chef Infra Client, version 17.1.35
       Patents: https://www.chef.io/patents
       Using policy 'kitchen_multi_suites_same_vm' at revision 'bed0e262b9bc071b400f25068be0a5f75240f2b07584cb6cc0a666bcb2dc8599'
       resolving cookbooks for run list: ["kitchen_multi_suites_same_vm::default@0.1.0 (60c4895)"]
       Synchronizing Cookbooks:
         - kitchen_multi_suites_same_vm (0.1.0)
       Installing Cookbook Gems:
       Compiling Cookbooks...
       Converging 4 resources
       Recipe: kitchen_multi_suites_same_vm::default
         * log[Running the default recipe] action write
       Recipe: kitchen_multi_suites_same_vm::reconfigure
         * log[reconfigure] action write
         * file[/tmp/cookbook-run-reconfigure] action create
           - create new file /tmp/cookbook-run-reconfigure
           - restore selinux security context
         * file[/tmp/cookbook-run-install] action delete
           - delete file /tmp/cookbook-run-install

       Running handlers:
       Running handlers complete
       Chef Infra Client finished, 2/4 resources updated in 02 seconds
       Downloading files from <reconfigure-centos-8>
       Finished converging <reconfigure-centos-8> (0m7.80s).
-----> Setting up <reconfigure-centos-8>...
       Finished setting up <reconfigure-centos-8> (0m0.00s).
-----> Verifying <reconfigure-centos-8>...
       Loaded tests from {:path=>".Users.myuser.dev.tmp.kitchen_multi_suites_same_vm.test.integration.default.reconfigure_test.rb"}

Profile: tests from {:path=>"/Users/myuser/dev/tmp/kitchen_multi_suites_same_vm/test/integration/default/reconfigure_test.rb"} (tests from {:path=>".Users.myuser.dev.tmp.kitchen_multi_suites_same_vm.test.integration.default.reconfigure_test.rb"})
Version: (not specified)
Target:  ssh://vagrant@127.0.0.1:2200

  File /tmp/cookbook-run-install
     ✔  is expected not to exist
  File /tmp/cookbook-run-reconfigure
     ✔  is expected to exist

Test Summary: 2 successful, 0 failures, 0 skipped
       Finished verifying <reconfigure-centos-8> (0m0.82s).
-----> Creating <uninstall-centos-8>...
       [Dummy] Create on instance=#<Kitchen::Instance:0x00007f953cad0920> with state={:my_id=>"uninstall-centos-8-1621957906"}
       Finished creating <uninstall-centos-8> (0m0.00s).
-----> Converging <uninstall-centos-8>...
       Preparing files for transfer
       Installing cookbooks for Policyfile /Users/myuser/dev/tmp/kitchen_multi_suites_same_vm/Policyfile.rb using `/usr/local/bin/chef-cli install`
       Installing cookbooks from lock
       Installing kitchen_multi_suites_same_vm 0.1.0
       Preparing dna.json
       Exporting cookbook dependencies from Policyfile /var/folders/lb/9lk_d_6x6qz3d04r5tfhs_tw0000gp/T/uninstall-centos-8-sandbox-20210525-35851-1u4ruzy using `/usr/local/bin/chef-cli export`...
       Exported policy 'kitchen_multi_suites_same_vm' to /var/folders/lb/9lk_d_6x6qz3d04r5tfhs_tw0000gp/T/uninstall-centos-8-sandbox-20210525-35851-1u4ruzy

       To converge this system with the exported policy, run:
         cd /var/folders/lb/9lk_d_6x6qz3d04r5tfhs_tw0000gp/T/uninstall-centos-8-sandbox-20210525-35851-1u4ruzy
         chef-client -z
       Removing non-cookbook files before transfer
       Preparing validation.pem
       Preparing client.rb
-----> Chef installation detected (install only if missing)
       Transferring files to <uninstall-centos-8>
       Starting Chef Infra Client, version 17.1.35
       Patents: https://www.chef.io/patents
       Using policy 'kitchen_multi_suites_same_vm' at revision 'bed0e262b9bc071b400f25068be0a5f75240f2b07584cb6cc0a666bcb2dc8599'
       resolving cookbooks for run list: ["kitchen_multi_suites_same_vm::default@0.1.0 (60c4895)"]
       Synchronizing Cookbooks:
         - kitchen_multi_suites_same_vm (0.1.0)
       Installing Cookbook Gems:
       Compiling Cookbooks...
       Converging 4 resources
       Recipe: kitchen_multi_suites_same_vm::default
         * log[Running the default recipe] action write
       Recipe: kitchen_multi_suites_same_vm::uninstall
         * log[uninstall] action write
         * file[/tmp/cookbook-run-uninstall] action create
           - create new file /tmp/cookbook-run-uninstall
           - restore selinux security context
         * file[/tmp/cookbook-run-reconfigure] action delete
           - delete file /tmp/cookbook-run-reconfigure

       Running handlers:
       Running handlers complete
       Chef Infra Client finished, 2/4 resources updated in 02 seconds
       Downloading files from <uninstall-centos-8>
       Finished converging <uninstall-centos-8> (0m7.16s).
-----> Setting up <uninstall-centos-8>...
       Finished setting up <uninstall-centos-8> (0m0.00s).
-----> Verifying <uninstall-centos-8>...
       Loaded tests from {:path=>".Users.myuser.dev.tmp.kitchen_multi_suites_same_vm.test.integration.default.uninstall_test.rb"}

Profile: tests from {:path=>"/Users/myuser/dev/tmp/kitchen_multi_suites_same_vm/test/integration/default/uninstall_test.rb"} (tests from {:path=>".Users.myuser.dev.tmp.kitchen_multi_suites_same_vm.test.integration.default.uninstall_test.rb"})
Version: (not specified)
Target:  ssh://vagrant@127.0.0.1:2200

  File /tmp/cookbook-run-install
     ✔  is expected not to exist
  File /tmp/cookbook-run-reconfigure
     ✔  is expected not to exist
  File /tmp/cookbook-run-uninstall
     ✔  is expected to exist

Test Summary: 3 successful, 0 failures, 0 skipped
       Finished verifying <uninstall-centos-8> (0m0.76s).
-----> Test Kitchen is finished. (0m45.51s)
```

* `kitchen list` will now show the `Verified` last action status and instances can be removed with `kitchen destroy`

```plain
$ kitchen list
Instance              Driver   Provisioner  Verifier  Transport  Last Action  Last Error
install-centos-8      Vagrant  ChefZero     Inspec    Ssh        Verified     <None>
reconfigure-centos-8  Dummy    ChefZero     Inspec    Ssh        Verified     <None>
uninstall-centos-8    Dummy    ChefZero     Inspec    Ssh        Verified     <None>

$ kitchen destroy                                                                                                                                                       [10:53:45]
-----> Starting Test Kitchen (v2.11.2)
-----> Destroying <install-centos-8>...
       ==> default: Forcing shutdown of VM...
       ==> default: Destroying VM and associated drives...
       Vagrant instance <install-centos-8> destroyed.
       Finished destroying <install-centos-8> (0m4.92s).
-----> Destroying <reconfigure-centos-8>...
       [Dummy] Destroy on instance=#<Kitchen::Instance:0x00007fc56aaf8b60> with state={:my_id=>"reconfigure-centos-8-1621957897", :last_action=>"verify", :last_error=>nil}
       Finished destroying <reconfigure-centos-8> (0m0.00s).
-----> Destroying <uninstall-centos-8>...
       [Dummy] Destroy on instance=#<Kitchen::Instance:0x00007fc56aaeaf60> with state={:my_id=>"uninstall-centos-8-1621957906", :last_action=>"verify", :last_error=>nil}
       Finished destroying <uninstall-centos
```
