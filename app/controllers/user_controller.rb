# frozen_string_literal: true

# Processing user requests
class UserController < ApplicationController
  def show
    result = User::SearchRepos.new(login_param).call

    render json: result
  end

  def repo
    result = User::SearchCommits.new(repo_params).call

    render json: result
  end

  private

  def login_param
    @login_param ||= params.permit(:login)[:login]
  end

  def repo_param
    @repo_param ||= params.permit(:repo)[:repo]
  end

  def repo_params
    params.permit(:login, :repo)
  end
end
