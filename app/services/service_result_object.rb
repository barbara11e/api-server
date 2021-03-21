# frozen_string_literal: true

class ServiceResultObject
  def initialize(success, response)
    @success = success
    @response = response
  end

  def success?
    @success == true
  end

  def failure?
    !success?
  end

  def message
    return '' if success?

    data[:errors].first.fetch(:title, '')
  end

  def backtrace
    []
  end

  def log
    success? ? Rails.logger.info(data) : Rails.logger.error(data)
  end

  private

  attr_reader :success, :response
end
