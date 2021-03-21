# frozen_string_literal: true

# Module for creating Service-Object. The module ust be included in SO class,
# the init and #call be declared
module ServiceObject
  extend ActiveSupport::Concern

  def handle_success(data)
    ServiceResultObject.new(true, data)
  end

  def handle_error(msg)
    ServiceResultObject.new(false, error: msg)
  end
end
