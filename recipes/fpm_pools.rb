#
# Cookbook Name:: sites
# Recipe:: default
#
# Copyright 2014, Yehuda Mond Foundation
#
# All rights reserved - Do Not Redistribute
#

# Based On:
# Cookbook Name:: nginx_conf
# Recipe:: default
#
# Copyright 2012, Firebelly Design
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

Array(node[:php][:fpm][:pools]).each do |site|
  site.each do |name,options|
    conf = {
      :action => :create,
      :name => nil,
      :cookbook => nil,
      :template => nil,
      :use_socket => nil,
      :socket_path => nil,
      :socket_owner => nil,
      :socket_group => nil,
      :socket_mode => nil,
      :tcp_backlog => nil,
      :tcp_port => nil,
      :ip_address => nil,
      :ip_whitelist => nil,
      :process_owner => nil,
      :process_group => nil,
      :max_children => nil,
      :start_servers => nil,
      :min_spare_servers => nil,
      :max_spare_servers => nil,
      :process_idle_timeout => nil,
      :max_requests => nil,
      :status_url => nil,
      :ping_url => nil,
      :ping_response => nil,
      :log_filename => nil,
      :log_format => nil,
      :slow_filename => nil,
      :slow_timeout => nil,
      :valid_extensions => nil,
      :terminate_timeout => nil,
      :initial_directory => nil,
      :flag_overrides => nil,
      :value_overrides => nil,
      :env_overrides => nil
    }.merge(options)
p conf
    php_fpm_pool_file name do
      action               conf['action']
      name                 conf['name']
      cookbook             conf['cookbook']
      template             conf['template']
      use_socket           conf['use_socket']
      socket_path          conf['socket_path']
      socket_owner         conf['socket_owner']
      socket_group         conf['socket_group']
      socket_mode          conf['socket_mode']
      tcp_backlog          conf['tcp_backlog']
      tcp_port             conf['tcp_port']
      ip_address           conf['ip_address']
      ip_whitelist         conf['ip_whitelist']
      process_owner        conf['process_owner']
      process_group        conf['process_group']
      max_children         conf['max_children']
      start_servers        conf['start_servers']
      min_spare_servers    conf['min_spare_servers']
      max_spare_servers    conf['max_spare_servers']
      process_idle_timeout conf['process_idle_timeout']
      max_requests         conf['max_requests']
      status_url           conf['status_url']
      ping_url             conf['ping_url']
      ping_response        conf['ping_response']
      log_filename         conf['log_filename']
      log_format           conf['log_format']
      slow_filename        conf['slow_filename']
      slow_timeout         conf['slow_timeout']
      valid_extensions     conf['valid_extensions']
      terminate_timeout    conf['terminate_timeout']
      initial_directory    conf['initial_directory']
      flag_overrides       conf['flag_overrides']
      value_overrides      conf['value_overrides']
      env_overrides        conf['env_overrides']
    end
  end
end
