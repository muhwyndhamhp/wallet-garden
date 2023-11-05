class Transaction < ApplicationRecord
  belongs_to :source_wallet, class_name: 'Wallet', optional: true
  belongs_to :target_wallet, class_name: 'Wallet', optional: true

  enum type: {
    invalid: 0,
    debit: 1,
    credit: 2,
  }

  validates :amount, presence: true
  validates :type, presence: true, not_invalid: true
  validate :source_target_present

  def source_target_present
    if type == debit! && source_wallet.nil?
      errors.add(:base, 'Source Wallet for Debit Transaction could not be empty')
    elsif type == credit! && target_wallet.nil?
      errors.add(:base, 'Target Wallet for Credit Transaction could not be empty')
    end
  end
end
