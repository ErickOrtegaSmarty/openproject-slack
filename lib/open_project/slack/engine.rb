# Prevent load-order problems in case openproject-plugins is listed after a plugin in the Gemfile
# or not at all
require 'open_project/plugins'

module OpenProject::Slack
  class Engine < ::Rails::Engine
    engine_name :openproject_slack

    include OpenProject::Plugins::ActsAsOpEngine

    register(
      'openproject-slack',
      author_url: 'https://www.openproject.org',
      requires_openproject: '>= 10.0.0'
    ) do
      menu :project_menu,
           :slack,
           { controller: '/slack', action: 'index', id: :openproject_slack },
           caption: :label_slack_plugin,
           icon: 'icon2 icon-slack'
    
           project_module :slack do |_map|
            permission :view_slack, slack: %i[index show download]
          end
        end

    initializer 'slack.register_hooks' do
      require 'open_project/slack/hook_listener'
    end
    add_api_path :documents do
      "#{root}/documents"
    end
  end
end
