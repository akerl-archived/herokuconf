require 'heroku-api'
require 'netrc'

##
# Base module for HerokuConf
module HerokuConf
  class << self
    DEFAULT_OPTIONS = {
      app: nil,
      keys: nil,
      exclude: ['RACK_ENV']
    }

    def configure!(params = {})
      return if ENV['DYNO']
      app, keys, exclude = DEFAULT_OPTIONS.dup.merge!(params).values_at(
        :app, :keys, :exclude
      )
      pairs = config_vars(app)
      pairs.select! { |k, _| keys.include? k } if keys
      pairs.reject! { |k, _| exclude.include? k } if exclude
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
