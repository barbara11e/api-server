# frozen_string_literal: true

require 'rails_helper'

describe Users::SearchRepos do
  subject { described_class.new(params).call }

  let(:params) { { login: :some_login, repo: :some_repo_name } }

  context 'when passed valid parameters' do
    context 'github.api reposponse successfuly' do
      it_behaves_like 'successful call'

      it 'returns success list repos' do
      end
    end

    context 'github.api send failed reposponse' do
      it_behaves_like 'unsuccessful call'

      it 'returns error message' do
      end
    end
  end

  context 'when passed invalid parameters' do
    it_behaves_like 'unsuccessful call'

    it 'return error message' do
    end
  end
end
