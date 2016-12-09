#
# Cookbook Name:: systemd-mountpoint-bug
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

mount_unit_content = <<~eos
  # This file is managed by Chef for node #{node['fqdn']}"
  [Unit]
  After=umount.target swap.target

  [Mount]
  What=tmpfs
  Where=/foo-bar
  Type=tmpfs
  Options=rw,noatime
eos

systemd_unit 'foo\x2dbar.mount' do
  triggers_reload true
  content mount_unit_content
  action [:create, :enable, :start]
end
