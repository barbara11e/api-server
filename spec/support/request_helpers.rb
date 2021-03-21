# frozen_string_literal: true

module RequestHelpers
	TOKEN = 'd41d8cd98f00b204e9800998ecf8427e'

	def response_json
		JSON.parse(response.body)
	end

	def response_data
		response_json['data']
	end

	def response_included
		response_json['included']
	end

	def response_errors
		response_json['errors']
	end

	def jsonapi_data_format(object)
		serializable_resource = ActiveModelSerializers::SerializableResource.new(object)
		JSON.parse(serializable_resource.to_json)
	end
end
  