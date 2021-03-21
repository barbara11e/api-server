# frozen_string_literal: true

require 'httpclient'

module User
  class SearchRepos
    include ServiceObject

    # @login [Hash] Github login
    def initialize(login)
      @login = login
    end

    def call
      result = validate!
      return result if result.failure?

      repos_result = handle_request

      handle_success(repos_result)
    rescue StandardError => e
      Rails.logger.error e

      handle_error(e.message)
    end

    private

    attr_reader :login

    def validate!
      handle_success('valid')
    end

    def handle_request
      repos_data = fetch_repos

      repos = repos_data.map { |repo| { name: repo['name'], created_at: repo['created_at'] } }[0, 10]
      {
        user: {
          name: login
        },
        repositories: repos
      }
    end

    def fetch_repos
      client = HTTPClient.new
      response = client.request(:get, address)

      unless HTTP::Status.successful?(response.status)
        raise HTTPClient::BadResponseError,
              "#{response.status} status. Repository is not found."
      end

      JSON.parse(response.body)
    end

    def address
      # TODO: fetch address from env
      # TODO: use URI::Generic.build
      "https://api.github.com/users/#{login}/repos"
    end
  end
end
