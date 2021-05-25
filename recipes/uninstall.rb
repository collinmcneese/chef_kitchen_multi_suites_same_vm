#
# Cookbook:: kitchen_multi_suites_same_vm
# Recipe:: uninstall
#
# Copyright:: 2021, Collin McNeese, Apache-2.0

log 'uninstall' do
  level :info
end

file '/tmp/cookbook-run-uninstall'

file '/tmp/cookbook-run-reconfigure' do
  action :delete
end
