class Transaction < ApplicationRecord
  belongs_to :source_wallet, class_name: 'Wallet', optional: true
  belongs_to :target_wallet, class_name: 'Wallet', optional: true

  enum type: {
    invalid: 0,
    debit: 1,
    credit: 2,
  }
end
