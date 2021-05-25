#
# Cookbook:: kitchen_multi_suites_same_vm
# Recipe:: install
#
# Copyright:: 2021, Collin McNeese, Apache-2.0

log 'install' do
  level :info
end

file '/tmp/cookbook-run-install'
