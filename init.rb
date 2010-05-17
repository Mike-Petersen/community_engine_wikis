config.after_initialize do
  if RAILS_ENV == 'development'
    ActiveSupport::Dependencies.load_once_paths = ActiveSupport::Dependencies.load_once_paths.select {|path| (path =~ /(community_engine_wikis)/).nil? }
  end
end

require_plugin 'community_engine'
require_plugin 'resource_controller'

config.plugin_paths += ["#{RAILS_ROOT}/vendor/plugins/community_engine_wikis/plugins"]

I18n.load_path += Dir[ (File.join(RAILS_ROOT, "vendor", "plugins", "community_engine_wikis", "lang", "ui", '*.{rb,yml}')) ]
I18n.reload!
