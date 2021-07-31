require "net/http"
require "net/https"

module ApiSabeqPsV1
  module SabeqHelpers
    REQUEST_HEADER = {'Content-Type' => 'application/json'}
    SABEQ_URL = "https://sabeq.ps"

    # Authorize the request
    # parameters: login_token
    # return: true, auth_token in case of success
    #         false, errors in case of failure, errors contain code and message
    def authorize(login_token)
      auth_link = SABEQ_URL + "/api/v1/auth"
      auth_json = { login_token: login_token }
      json_response = make_post_request(auth_link, auth_json)

      result, the_response = get_error_or_returned_value(json_response)
      if result
        return true, the_response["auth_token"]
      else
        return false, the_response
      end
    end

    # Verify the business profile
    def verify_profile(auth_token, profile_id, api_key)
      auth_link = SABEQ_URL + "/api/v1/verify_business"
      auth_json = { auth_token: auth_token, profile_id: profile_id, api_key: api_key }
      json_response = make_post_request(auth_link, auth_json)

      result, the_response = get_error_or_returned_value(json_response)
      if result
        return true, the_response["verification_token"]
      else
        return false, the_response
      end
    end

    def query_parcel(verification_token, parcel_number)
      auth_link = SABEQ_URL + "/api/v1/parcels/#{parcel_number}"
      auth_json = { verification_token: verification_token }
      json_response = make_get_request(auth_link, auth_json)
      return json_response
    end

    def get_areas(verification_token)
      auth_link = SABEQ_URL + "/api/v1/parcels/get_areas"
      auth_json = { verification_token: verification_token }
      json_response = make_get_request(auth_link, auth_json)
      return json_response
    end

    def create_parcel(verification_token, name, phone1, phone2, content,
                     payment_amount, area_id, address, delivery_notes)
      auth_link = SABEQ_URL + "/api/v1/parcels"
      auth_json = { verification_token: verification_token,
                    name: name, phone1: phone1, phone2: phone2,
                    content: content, payment_amount: payment_amount,
                    area_id: area_id, address: address,
                    delivery_notes: delivery_notes }
      json_response = make_post_request(auth_link, auth_json)

      return json_response
    end

    private
      def make_post_request(url_link, json_content)
        uri = URI.parse(url_link)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        a_request = Net::HTTP::Post.new(uri.request_uri, REQUEST_HEADER)
        a_request.body = json_content.to_json
        a_response = http.request(a_request)
        return a_response.body
      end

      def make_get_request(url_link, json_content)
        uri = URI.parse(url_link)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        the_params = json_content
        uri.query = URI.encode_www_form(the_params)
        a_request = Net::HTTP::Get.new(uri.request_uri)
        a_response = http.request(a_request)
        return a_response.body
      end

      def get_error_or_returned_value(json_response)
        # check if the response has errors
        hashed_response = JSON.parse(json_response)
        errors = hashed_response["errors"]

        if errors.present?
          return false, errors
        else
          return true, hashed_response
        end
      end
  end
end
