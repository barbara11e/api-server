# frozen_string_literal: true

require 'rails_helper'

describe Users::SearchCommits do
  subject { described_class.new(params).call }

  let(:params) { { login: :some_login, repo: :some_repo_name } }

  context 'when paased valid parameters' do
    it_behaves_like 'successful call'
  end

  context 'when paased valid parameters' do
    it_behaves_like 'unsuccessful call'
  end
end
