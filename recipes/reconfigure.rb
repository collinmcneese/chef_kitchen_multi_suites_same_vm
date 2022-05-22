#
# Cookbook:: kitchen_multi_suites_same_vm
# Recipe:: reconfigure
#


log 'reconfigure' do
  level :info
end

file '/tmp/cookbook-run-reconfigure'

file '/tmp/cookbook-run-install' do
  action :delete
end
