require 'netrc'
require 'heroku-api'

module HerokuConf
  ##
  # App object for parsing Heroku configs
  class App
    def initialize(params = {})
      @app = params[:app]
    end

    def configure!(keys = nil)
      pairs = config_vars
      pairs.select! { |k, _| keys.include? k } if keys
      pairs.each { |k, v| ENV[k] = v }
    end

    private

    def config_vars
      client.get_config_vars(app).body
    end

    def app
      @app ||= parse_app
    end

    def parse_app
      remotes.first[1].split('/').last.split('.').first
    end

    def remotes
      @remote ||= parse_remotes
    end

    def parse_remotes
      remotes = `git remote -v`.split("\n").map(&:split)
      remotes.select! { |x| x.first == 'heroku' && x.last == '(push)' }
      fail('No app found') unless remotes.size == 1
      remotes
    end

    def client
      @client ||= Heroku::API.new(api_key: api_key)
    end

    def api_key
      @api_key ||= Netrc.read['api.heroku.com'].password
    end
  end
end
