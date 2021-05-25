#
# Cookbook:: kitchen_multi_suites_same_vm
# Recipe:: default
#
# Copyright:: 2021, Collin McNeese, Apache-2.0

log 'Running the default recipe'

include_recipe 'kitchen_multi_suites_same_vm::install'     if node['kitchen_multi_suites_same_vm']['action'] == 'install'
include_recipe 'kitchen_multi_suites_same_vm::reconfigure' if node['kitchen_multi_suites_same_vm']['action'] == 'reconfigure'
include_recipe 'kitchen_multi_suites_same_vm::uninstall'   if node['kitchen_multi_suites_same_vm']['action'] == 'uninstall'
