class PaymentsController < ApplicationController
    require 'net/http'
    require 'net/https'
    require 'uri'
    require 'json'
    
    # important constants
    CONSUMER_KEY = 'Qc2tfjP3fDZE7XXveM2SkxIbyy8XoH2f'
    CONSUMER_SECRET = 'Sg8WZUtVgbXAPnUn'
    SHORTCODE = '601521'
    INITIATIOR_NAME = 'apitest361'
    MSISDN	= '254708374149'
    LNM_SHORTCODE = '174379'
    
        # register url
        RESPONSE_TYPE = "Cancelled"
        CONFIRMATION_URL = 'http://hiresafe.herokuapp.com/payments/confirm'
        VALIDATION_URL = 'http://hiresafe.herokuapp.com/payments/validate'
        
    # dev only
    def show_token
        render plain: access_token
    end
    
    def register
        render plain: register_url
    end
    
    # validation and confirmation URLs, publicly available
    def confirm
        render plain: params
    end
    
    def validate
        render plain: params
    end
    
    
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
    
    def register_url
        uri = URI('https://sandbox.safaricom.co.ke/mpesa/c2b/v1/registerurl')
        
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        
        request = Net::HTTP::Get.new(uri)
        request["accept"] = 'application/json'
        request["content-type"] = 'application/json'
        request["authorization"] = "Bearer #{access_token}" # token added
        request.body = "{\"ShortCode\":\"#{SHORTCODE}\",
            \"ResponseType\":\"#{RESPONSE_TYPE}\",
            \"ConfirmationURL\":\"#{CONFIRMATION_URL}\",
            \"ValidationURL\":\"#{VALIDATION_URL}\"}"
        
        response = http.request(request)
        # puts response.read_body
        
        response.body
    end
            
end
