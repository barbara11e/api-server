# frozen_string_literal: true

module ServiceHelpers
  def stub_service_request(method, url, params, response_params = {})
    stub_request(method, url)
      .with(query: params)
      .to_return body: response_params[:body].to_json,
                  status: (response_params[:status] || 200),
                  headers: (response_params[:headers] || {})
  end
end
