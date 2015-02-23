##
# Base module for HerokuConf
module HerokuConf
  class << self
    DEFAULT_OPTIONS = {
      app: nil,
      keys: []
    }

    def configure!(params = {})
      return if ENV['DYNO']
      options = DEFAULT_OPTIONS.dup.merge! params
      pairs = config_vars(options[:app])
      pairs.select! { |k, _| options[:keys].include? k } if keys
      pairs.each { |k, v| ENV[k] = v }
    end

    private

    def config_vars(app = nil)
      app ||= parse_app
      client.get_config_vars(app).body
    end

    def parse_app
      remotes.first[1].split('/').last.split('.').first
    end

    def remotes
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
