#
# Cookbook:: kitchen_multi_suites_same_vm
# Recipe:: uninstall
#


log 'uninstall' do
  level :info
end

file '/tmp/cookbook-run-uninstall'

file '/tmp/cookbook-run-reconfigure' do
  action :delete
end
