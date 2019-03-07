class CreateValidations < ActiveRecord::Migration[5.2]
  def change
    create_table :validations do |t|
      t.string :TransactionType
      t.string :TransID
      t.string :TransTime
      t.string :TransAmount
      t.string :BusinessShortCode
      t.string :BillRefNumber
      t.string :InvoiceNumber
      t.string :OrgAccountBalance
      t.string :ThirdPartyTransID
      t.string :MSISDN
      t.string :FirstName
      t.string :MiddleName
      t.string :LastName

      t.timestamps
    end
  end
end
