#
# Cookbook:: end_to_end
# Recipe:: chef-vault
#
# Copyright:: 2020, Chef Software, Inc.
#

chef_data_bag "creds"

openssl_rsa_private_key "/root/bob_bobberson.pem" do
  key_length 2048
  action :create
end

chef_client "bob_bobberson" do
  source_key_path "/root/bob_bobberson.pem"
end

chef_node "bob_bobberson"

chef_vault_secret "super_secret_1" do
  data_bag "creds"
  raw_data("auth" => "1234")
  admins "bob_bobberson"
  search "*:*"
end

chef_vault_secret "super_secret_2" do
  data_bag "creds"
  raw_data("auth" => "4321")
  admins "bob_bobberson"
end
