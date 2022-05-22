#
# Cookbook:: kitchen_multi_suites_same_vm
# Recipe:: install
#


log 'install' do
  level :info
end

file '/tmp/cookbook-run-install'
