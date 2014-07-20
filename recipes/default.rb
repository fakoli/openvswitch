#
# Cookbook Name:: openvswitch
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "Removing bridge modules" do
    command "rmmod bridge"
    only_if "grep bridge modules"
    action :run
end

template "/etc/modprobe.d/blacklist-bridge.conf" do
  source "blacklist-bridge.conf.erb"
  owner "root"
  group "root"
  mode 00644
end

execute "remove_hba_firmware" do
  command "yum remove -y bfa-firmware.noarch "
  action :run
end

package "openvswitch" do
  action :install
end

execute "enable-BRCOMPAT" do
  command "sed -i 's/# BRCOMPAT=yes/BRCOMPAT=yes/' /etc/sysconfig/openvswitch"
  action :run
end

execute "remove_libvirt_bridge" do
  command "virsh net-destroy default; virsh net-undefine default"
  only_if "virsh net-list | grep default"
  action :run
end

service "openvswitch" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

execute "backup_interface_configs" do
  command "cp /etc/syconfig/ifcfg-* /tmp/"
  action :nothing
end

template "/etc/sysconfig/network-scripts/ifcfg-eth0" do
  source "ifcfg-eth0.erb"
  owner "root"
  group "root"
  mode 00644
end

template "/etc/sysconfig/network-scripts/ifcfg-ovsbr0" do
  source "ifcfg-ovsbr0.erb"
  owner "root"
  group "root"
  mode 00644
end

execute "network-restart" do
  command "nohup service network restart"
  action :run
end








