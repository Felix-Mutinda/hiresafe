class PaymentsController < ApplicationController
    require 'net/http'
    require 'net/https'
    require 'uri'
    require 'json'
    require 'base64'
    
    # important constants
    CONSUMER_KEY = 'Qc2tfjP3fDZE7XXveM2SkxIbyy8XoH2f'
    CONSUMER_SECRET = 'Sg8WZUtVgbXAPnUn'
    SHORTCODE = '601521'
    INITIATIOR_NAME = 'apitest361'
    MSISDN	= '254708374149'
    LNM_SHORTCODE = '174379'
    SIMULATE_AMOUNT = '10'
    BILLREFNUMBER = 'hiresafe'
    PARTYA = '254798904053'
    LNM_CALLBACK = 'http://hiresafe.herokuapp.com/payments/lnm_callback'
    TRANSACTIONDESC = 'Car Hire Payment'
    ACCOUNTREFERENCE = 'hiresafe'
    
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
    
    def c2bsimulate
        render plain: c2b_simulate
    end
    
    def stkpush
        render plain: stk_push
    end
    
    # validation and confirmation URLs, publicly available
    def confirm
        render plain: params
    end
    
    def validate
        render plain: params
    end
    
    # lipa na mpesa callback
    def lnm_callback
        render plain: params
    end
    
    
private
    def access_token
        uri = URI('https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials')
        res = nil
        
        Net::HTTP.start(uri.host, uri.port,
          :use_ssl => uri.scheme == 'https',
          :verify_mode => OpenSSL::SSL::VERIFY_NONE)    do |http|
        
          request = Net::HTTP::Get.new uri.request_uri
          request.basic_auth CONSUMER_KEY, CONSUMER_SECRET
        
          res = http.request request # Net::HTTPResponse object
        end
        
        if res.code == '200'
            response_json = JSON.parse(res.body)
            response_json['access_token']
        else
            res.body
            res.code
        end
    end
    
    def register_url
        uri = URI('https://sandbox.safaricom.co.ke/mpesa/c2b/v1/registerurl')
        res = nil
        
        Net::HTTP.start(uri.host, uri.port,
            :use_ssl => uri.scheme == 'https',
            :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|
            
            request = Net::HTTP::Get.new(uri.request_uri)
            request["accept"] = 'application/json'
            request["content-type"] = 'application/json'
            request["authorization"] = "Bearer #{access_token}" # token added
            request.body = "{\"ShortCode\":\"#{SHORTCODE}\",
                \"ResponseType\":\"#{RESPONSE_TYPE}\",
                \"ConfirmationURL\":\"#{CONFIRMATION_URL}\",
                \"ValidationURL\":\"#{VALIDATION_URL}\"}"
            
            res = http.request(request)
        end
        
        res.body
        res.code
    end
    
    def c2b_simulate
        uri = URI('https://sandbox.safaricom.co.ke/mpesa/c2b/v1/simulate')
        
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        
        request = Net::HTTP::Get.new(uri)
        request["accept"] = 'application/json'
        request["content-type"] = 'application/json'
        request["authorization"] = "Bearer #{access_token}"
        request.body = "{ \"ShortCode\":\"#{SHORTCODE}\",
          \"CommandID\":\"CustomerPayBillOnline\",
          \"Amount\":\"#{SIMULATE_AMOUNT}\",
          \"Msisdn\":\"#{MSISDN}\",
          \"BillRefNumber\":\"#{BILLREFNUMBER}\" }"
        
        response = http.request(request)
        #puts response.read_body
        
        response.body
        response.code
    end
    
    def stk_push
        uri = URI('https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest')
        
        # lipa na mpesa password generation
        timestamp = DateTime.now.strftime("%Y%m%d%H%M%S")
        passkey = 'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919'
        password = Base64.encode64(LNM_SHORTCODE + passkey + timestamp).split("\n").join
        
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        
        request = Net::HTTP::Get.new(uri)
        request["accept"] = 'application/json'
        request["content-type"] = 'application/json'
        request["authorization"] = "Bearer #{access_token}"
        
        request.body = "{\"BusinessShortCode\": \"#{LNM_SHORTCODE}\",
          \"Password\": \"#{password}\",
          \"Timestamp\": \"#{timestamp}\",
          \"TransactionType\": \"CustomerPayBillOnline\",
          \"Amount\": \"#{SIMULATE_AMOUNT}\",
          \"PartyA\": \"#{PARTYA}\",
          \"PartyB\": \"#{LNM_SHORTCODE}\",
          \"PhoneNumber\": \"#{PARTYA}\",
          \"CallBackURL\": \"#{LNM_CALLBACK}\",
          \"AccountReference\": \"#{ACCOUNTREFERENCE}\",
          \"TransactionDesc\": \"#{TRANSACTIONDESC}\"}"
        
        response = http.request(request)
        
        response.read_body
        response.code
    end
    
    # white list params
    
    def confirmation_params
        params.permit(
            :TransactionType,
            :TransID,
            :TransTime,
            :TransAmount,
            :BusinessShortCode,
            :BillRefNumber,
            :InvoiceNumber,
            :OrgAccountBalance,
            :ThirdPartyTransID,
            :MSISDN,
            :FirstName,
            :MiddleName,
            :LastName
        )
    end
    
    def validation_params
        confirmation_params
    end
           
end
