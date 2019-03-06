class PaymentsController < ApplicationController
    require 'http'
    require 'https'
    require 'uri'
    require 'json'
    
    # important constants
    CONSUMER_KEY = 'Qc2tfjP3fDZE7XXveM2SkxIbyy8XoH2f'
    CONSUMER_SECRET = 'Sg8WZUtVgbXAPnUn'
    
    
private
    def access_token
        uri = URI('https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials')
        response = nil
        
        Net::HTTP.start(uri.host, uri.port,
          :use_ssl => uri.scheme == 'https',
          :verify_mode => OpenSSL::SSL::VERIFY_NONE)    do |http|
        
          request = Net::HTTP::Get.new uri.request_uri
          request.basic_auth CONSUMER_KEY, CONSUMER_SECRET
        
          response = http.request request # Net::HTTPResponse object
        end
        
        response_json = JSON.parse(response.body)
        response_json['access_token']
    end
            
end
