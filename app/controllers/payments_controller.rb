class PaymentsController < ApplicationController
    require 'net/http'
    require 'net/https'
    require 'uri'
    require 'json'
    require 'base64'

    # oops
    skip_before_action :verify_authenticity_token
    
    # allow callbacks without login
    skip_before_action :authenticate_user!, only: [:confirm, :validate, :lnm_callback]
    
    # important constants
    BASE_URL = 'https://sandbox.safaricom.co.ke'
    CONSUMER_KEY = 'Qc2tfjP3fDZE7XXveM2SkxIbyy8XoH2f'
    CONSUMER_SECRET = 'Sg8WZUtVgbXAPnUn'
    SHORTCODE = '601521'
    INITIATIOR_NAME = 'apitest361'
    MSISDN	= '254708374149'
    LNM_SHORTCODE = '174379'
    SIMULATE_AMOUNT = '1'
    BILLREFNUMBER = 'hiresafe'
    PARTYA = '254798904053'
    LNM_CALLBACK = 'https://felix-mutinda-1.paiza-user.cloud:3000/payments/lnm_callback'
    TRANSACTIONDESC = 'Car Hire Payment'
    ACCOUNTREFERENCE = 'hiresafe'
    
        # register url
        RESPONSE_TYPE = "Cancelled"
        CONFIRMATION_URL = 'https://hiresafe.herokuapp.com/payments/confirm'
        VALIDATION_URL = 'https://hiresafe.herokuapp.com/payments/validate'
        
        
        
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
        
        # log params 
        logger.info confirmation_params
        
        # write to db
        conf = Confirmation.new confirmation_params
        
        if conf.save
            render json: '{
                "C2BPaymentConfirmationResult": "Success"
            }'
        else
            render json: '{
                "C2BPaymentConfirmationResult": "Failure"
            }'
        end
    end
    
    def validate
        
        # log params 
        logger.info confirmation_params
        
        # write to db
        conf = Confirmation.new validation_params
        
        if conf.save # validate the request here
            render json: '{
                "ResultCode": 0,
                "ResultDesc": "Accepted"
            }'
        else
            render json: '{
                "ResultCode": 1,
                "ResultDesc": "Rejected"
            }'
        end
    end
    
    # lipa na mpesa callback
    def lnm_callback
        
        # log params 
        logger.info lnm_callback_params
        
        # write to db
        callback = Lnmcallback.new lnm_callback_params
        
        callback.save
    end
    
    
private

    def encode_credentials key, secret
        credentials = "#{key}:#{secret}"
        encoded_credentials = Base64.encode64(credentials).split("\n").join
    end
    

    def access_token
        url = 'https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials'
        
        encode = encode_credentials CONSUMER_KEY, CONSUMER_SECRET
        headers = {
          "Authorization" => "Basic #{encode}"
        }
        
        response = HTTParty.get(url, headers: headers)
        
        if response.code == 200
            response_json = JSON.parse(response.body)
            response_json['access_token']
        else
            response.body
        end
    end
    
    def register_url
        url = 'https://sandbox.safaricom.co.ke/mpesa/c2b/v1/registerurl'
        
        headers = {
            "Authorization" => "Bearer #{access_token}",
            "Content-Type" => "application/json"
        }
        body = {
            ShortCode: "#{SHORTCODE}",
            ResponseType: "#{RESPONSE_TYPE}",
            ConfirmationURL: "#{CONFIRMATION_URL}",
            ValidationURL: "#{VALIDATION_URL}"
        }.to_json

        response = HTTParty.post(url, headers: headers, body: body)
        JSON.parse(response.body)
    end
    
    def c2b_simulate
        url = "#{BASE_URL}/mpesa/c2b/v1/simulate"
        
        headers = {
            "Authorization" => "Bearer #{access_token}",
            "Content-Type" => "application/json"
        }
        
        body = {
            ShortCode: "#{SHORTCODE}",
            CommandID: "CustomerPayBillOnline",
            Amount: "#{SIMULATE_AMOUNT}",
            Msisdn: "#{MSISDN}",
            BillRefNumber: "#{BILLREFNUMBER}"
        }.to_json
        
        response = HTTParty.post(url, headers: headers, body: body)
        JSON.parse(response.body)
    end
    
    def stk_push
        url = 'https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest'
        
        # lipa na mpesa password generation
        timestamp = DateTime.now.strftime("%Y%m%d%H%M%S")
        passkey = 'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919'
        password = Base64.encode64(LNM_SHORTCODE + passkey + timestamp).split("\n").join
        
        headers = {
          "Authorization" => "Bearer #{access_token}",
          "Content-Type" => "application/json"
        }
  
        body = {
          BusinessShortCode: "#{LNM_SHORTCODE}",
          Password: "#{password}",
          Timestamp: "#{timestamp}",
          TransactionType: "CustomerPayBillOnline",
          Amount: "#{SIMULATE_AMOUNT}",
          PartyA: "#{PARTYA}",
          PartyB: "#{LNM_SHORTCODE}",
          PhoneNumber: "#{PARTYA}",
          CallBackURL: "#{LNM_CALLBACK}",
          AccountReference: "#{ACCOUNTREFERENCE}",
          TransactionDesc: "#{TRANSACTIONDESC}"
        }.to_json
        
        response = HTTParty.post(url, headers: headers, body: body)
        JSON.parse(response.body)
        
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
    
    def lnm_callback_params
        # params.require(:Body).permit(:stkCallback)
        
        params_hash = {}
        
        response = params[:Body][:stkCallback]
        params_hash[:MerchantRequestID] = response[:MerchantRequestID]
        params_hash[:CheckoutRequestID] = response[:CheckoutRequestID]
        params_hash[:ResultCode] = response[:ResultCode]
        params_hash[:ResultDesc] = response[:ResultDesc]
        
        # successful request
        if (params_hash[:ResultCode]).to_i == 0
            metadata = response[:CallbackMetadata][:Item]
            
            params_hash[:Amount] = metadata[0][:Value]
            params_hash[:MpesaReceiptNumber] = metadata[1][:Value]
            params_hash[:Balance] = metadata[2][:Value]
            params_hash[:TransactionDate] = metadata[3][:Value]
            params_hash[:PhoneNumber] = metadata[4][:Value]
        end
        
        return params_hash
    end
           
end
