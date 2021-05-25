#
# Cookbook:: kitchen_multi_suites_same_vm
# Recipe:: reconfigure
#
# Copyright:: 2021, Collin McNeese, Apache-2.0

log 'reconfigure' do
  level :info
end

file '/tmp/cookbook-run-reconfigure'

file '/tmp/cookbook-run-install' do
  action :delete
end
