action :create do
	name                 = new_resource.name
	cookbook             = new_resource.cookbook ? new_resource.cookbook.to_s : 'php'
	template             = new_resource.template || 'fpm-pool.conf.erb'

	process_owner        = new_resource.process_owner || node['php']['fpm_user']
	process_group        = new_resource.process_group || node['php']['fpm_group']

	use_socket           = new_resource.use_socket
	socket_path          = new_resource.socket_path || "/var/run/php5-fpm-#{name}.sock"
	socket_owner         = new_resource.socket_owner || process_owner
	socket_group         = new_resource.socket_group || process_group
	socket_mode          = new_resource.socket_mode || '0660'
	tcp_backlog          = new_resource.tcp_backlog || 65535
	tcp_port             = new_resource.tcp_port || 9000
	ip_address           = new_resource.ip_address || '127.0.0.1'
	ip_whitelist         = new_resource.ip_whitelist || ['127.0.0.1']

	process_manager      = new_resource.process_manager
	max_children         = new_resource.max_children || 5
	min_spare_servers    = new_resource.min_spare_servers || 1
	max_spare_servers    = new_resource.max_spare_servers || 3
	start_servers        = new_resource.start_servers || (min_spare_servers + (max_spare_servers - min_spare_servers) / 2).ceil
	process_idle_timeout = new_resource.process_idle_timeout || '10s'

	max_requests         = new_resource.max_requests || 0
	status_url           = new_resource.status_url || '/status'
	ping_url             = new_resource.ping_url || '/ping'
	ping_response        = new_resource.ping_response || 'pong'
	log_filename         = new_resource.log_filename || ""
	log_format           = new_resource.log_format || "%R - %u %t \"%m %r\" %s"
	slow_filename        = new_resource.slow_filename || ""
	slow_timeout         = new_resource.slow_timeout || "0"
	valid_extensions     = new_resource.valid_extensions || ['.php']
	terminate_timeout    = new_resource.terminate_timeout || "0"
	initial_directory    = new_resource.initial_directory || '/'
	flag_overrides       = new_resource.flag_overrides || {}
	value_overrides      = new_resource.value_overrides || {}
	env_overrides        = new_resource.env_overrides || {}


	log_filename = node['php']['fpm_log_dir'] + "/" + log_filename unless (log_filename.empty? || log_filename.include?("/"))

	new_resource.updated_by_last_action(false)
	Chef::Log.info("Creating new PHP-FPM instance for #{new_resource.name}")
	a = template "#{node['php']['fpm_pool_dir']}/#{new_resource.name}.conf" do
		cookbook cookbook
		source template
		owner 'root'
		group 'root'
		variables({
			:name => name,
			:process_owner => process_owner,
			:process_group => process_group,
			:ip_address => ip_address,
			:tcp_port => tcp_port,
			:use_socket => use_socket,
			:socket_path => socket_path,
			:socket_owner => socket_owner,
			:socket_group => socket_group,
			:socket_mode => socket_mode,
			:ip_whitelist => ip_whitelist,
			:process_manager => process_manager,
			:max_children => max_children,
			:start_servers => start_servers,
			:min_spare_servers => min_spare_servers,
			:max_spare_servers => max_spare_servers,
			:max_requests => max_requests,
			:process_idle_timeout => process_idle_timeout,
			:tcp_backlog => tcp_backlog,
			:status_url => status_url,
			:ping_url => ping_url,
			:ping_response => ping_response,
			:log_filename => log_filename,
			:log_format => log_format,
			:slow_filename => slow_filename,
			:slow_timeout => slow_timeout,
			:valid_extensions => valid_extensions,
			:terminate_timeout => terminate_timeout,
			:initial_directory => initial_directory,
			:flag_overrides => flag_overrides,
			:value_overrides => value_overrides,
			:env_overrides => env_overrides
		})
		notifies :restart, 'service[php-fpm]'
		mode 00644
	end

	new_resource.updated_by_last_action(a.updated_by_last_action?)

end

action :delete do
	new_resource.updated_by_last_action(false)
	Chef::Log.info("Removing PHP-FPM instance #{new_resource.name}")

	a = file "#{node['php']['fpm_pool_dir']}/#{new_resource.name}.conf" do
		action :delete
		notifies :restart, 'service[php-fpm]'
	end

	new_resource.updated_by_last_action(a.updated_by_last_action?)

end

action :enable do
	Chef::Log.info("Enabling PHP-FPM instance #{new_resource.name}")

	only_if { ::File.exists("#{node['php']['fpm_pool_dir']}/#{new_resource.name}.disabled") }

	ruby_block "Rename config file" do
		block do
			::File.rename("#{node['php']['fpm_pool_dir']}/#{new_resource.name}.disabled", "#{node['php']['fpm_pool_dir']}/#{new_resource.name}.conf")
		end
	end

	notifies :restart, 'service[php-fpm]'
end

action :disable do
	Chef::Log.info("Disabling PHP-FPM instance #{new_resource.name}")

	only_if { ::File.exists("#{node['php']['fpm_pool_dir']}/#{new_resource.name}.conf") }

	ruby_block "Rename config file" do
		block do
			::File.rename("#{node['php']['fpm_pool_dir']}/#{new_resource.name}.conf", "#{node['php']['fpm_pool_dir']}/#{new_resource.name}.disabled")
		end
	end

	notifies :restart, 'service[php-fpm]'
end
