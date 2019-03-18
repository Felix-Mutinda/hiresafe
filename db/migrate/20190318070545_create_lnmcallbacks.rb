class CreateLnmcallbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :lnmcallbacks do |t|
      t.string :MerchantRequestID
      t.string :CheckoutRequestID
      t.string :ResultCode
      t.string :ResultDesc
      t.string :Amount
      t.string :MpesaReceiptNumber
      t.string :Balance
      t.string :TransactionDate
      t.string :PhoneNumber

      t.timestamps
    end
  end
end
