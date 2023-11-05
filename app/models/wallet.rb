class Wallet < ApplicationRecord
  belongs_to :user, polymorphic: true

  has_many :credit_transaction, class_name: 'Transaction', foreign_key: 'source_wallet_id'
  has_many :debit_transaction, class_name: 'Transaction', foreign_key: 'target_wallet_id'

  def balance
    credit_transaction.sum(:amount) - debit_transaction.sum(:amount)
  end
end
