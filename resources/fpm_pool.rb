actions :create, :delete, :enable, :disable

default_action :create

attribute :name,                 :kind_of  => [String                  ], :regex => /^[a-zA-Z0-9\._\-]{0,32}$/, :name_attribute => true
attribute :cookbook,             :kind_of  => [String,        NilClass ], :default => nil #Cookbook to find template
attribute :template,             :kind_of  => [String,        NilClass ], :default => nil # Template to use.

attribute :use_socket,           :kind_of  => [TrueClass, FalseClass   ], :default => true # Use a socket, or use port?
attribute :socket_path,          :kind_of  => [String,        NilClass ], :default => nil # Listening socket
attribute :socket_owner,         :kind_of  => [String,        NilClass ], :default => nil
attribute :socket_group,         :kind_of  => [String,        NilClass ], :default => nil
attribute :socket_mode,          :kind_of  => [String,        NilClass ], :default => nil

attribute :tcp_backlog,          :kind_of  => [Integer,       NilClass ], :default => nil
attribute :tcp_port,             :kind_of  => [Integer,       NilClass ], :default => nil
attribute :ip_address,           :kind_of  => [String,        NilClass ], :default => nil
attribute :ip_whitelist,         :kind_of  => [Array,         NilClass ], :default => nil

attribute :process_owner,        :kind_of  => [String,        NilClass ], :default => nil
attribute :process_group,        :kind_of  => [String,        NilClass ], :default => nil

attribute :process_manager,      :kind_of  => [Symbol                  ], :default => :dynamic, :equal_to => [:static, :dynamic, :ondemand]
attribute :max_children,         :kind_of  => [Integer,       NilClass ], :default => nil
attribute :start_servers,        :kind_of  => [Integer,       NilClass ], :default => nil
attribute :min_spare_servers,    :kind_of  => [Integer,       NilClass ], :default => nil
attribute :max_spare_servers,    :kind_of  => [Integer,       NilClass ], :default => nil
attribute :process_idle_timeout, :kind_of  => [String,        NilClass ], :default => nil # suffixed with (s)econds, (m)inutes, (h)ours, or (d)ays

attribute :max_requests,         :kind_of  => [Integer,       NilClass ], :default => nil
attribute :status_url,           :kind_of  => [String,        NilClass ], :default => nil
attribute :ping_url,             :kind_of  => [String,        NilClass ], :default => nil
attribute :ping_response,        :kind_of  => [String,        NilClass ], :default => nil
attribute :log_filename,         :kind_of  => [String,        NilClass ], :default => nil
attribute :log_format,           :kind_of  => [String,        NilClass ], :default => nil
attribute :slow_filename,        :kind_of  => [String,        NilClass ], :default => nil
attribute :slow_timeout,         :kind_of  => [String,        NilClass ], :default => nil # suffixed with (s)econds, (m)inutes, (h)ours, or (d)ays
attribute :valid_extensions,     :kind_of  => [Array,         NilClass ], :default => nil
attribute :terminate_timeout,    :kind_of  => [String,        NilClass ], :default => nil # suffixed with (s)econds, (m)inutes, (h)ours, or (d)ays
attribute :initial_directory,    :kind_of  => [String,        NilClass ], :default => nil
attribute :flag_overrides,       :kind_of  => [Hash,          NilClass ], :default => nil
attribute :value_overrides,      :kind_of  => [Hash,          NilClass ], :default => nil
attribute :env_overrides,        :kind_of  => [Hash,          NilClass ], :default => nil

def initialize(*args)
  super
  @action = :create
end
