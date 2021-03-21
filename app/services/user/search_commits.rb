# frozen_string_literal: true

require 'httpclient'

module User
  class SearchCommits
    include ServiceObject

    # @login [Hash] Github login
    def initialize(params)
      @login = params['login']
      @repo_name = params['repo']
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

    attr_reader :login, :repo_name

    def validate!
      handle_success('valid')
    end

    def handle_request
      repos_data = fetch_repo

      repos = repos_data.map do |repo|
                { message: repo['commit']['message'], commit_date: repo['commit']['committer']['date'] }
              end [0, 10]
      {
        repo: {
          name: repo_name,
          commits: repos
        }
      }
    end

    def fetch_repo
      client = HTTPClient.new
      response = client.request(:get, address)
      # TODO: create two different errors

      unless HTTP::Status.successful?(response.status)
        raise HTTPClient::BadResponseError,
              "#{response.status} status. Repository is not found."
      end

      JSON.parse(response.body)
    end

    def address
      # TODO: fetch address from env
      # TODO: use URI::Generic.build
      "https://api.github.com/repos/#{login}/#{repo_name}/commits"
    end
  end
end
