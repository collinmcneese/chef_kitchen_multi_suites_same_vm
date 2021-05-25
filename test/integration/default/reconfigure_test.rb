# InSpec test for recipe kitchen_multi_suites_same_vm::reconfigure

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

describe file('/tmp/cookbook-run-install') do
  it { should_not exist }
end

describe file('/tmp/cookbook-run-reconfigure') do
  it { should exist }
end
