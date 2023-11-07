# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :source_wallet, class_name: 'Wallet', optional: true
  belongs_to :target_wallet, class_name: 'Wallet', optional: true

  enum operation_types: {
    debit: 1,
    credit: 2,
    transfer: 3
  }

  validates :amount, presence: true
  validates :operation, inclusion: { in: operation_types.values }
  validate :source_target_present

  def source_target_present
    if operation == Transaction.operation_types[:debit] && source_wallet.nil?
      raise ArgumentError,'Source Wallet for Debit Transaction could not be empty'
    elsif operation == Transaction.operation_types[:credit] && target_wallet.nil?
      raise ArgumentError,'Target Wallet for Credit Transaction could not be empty'
    elsif operation == Transaction.operation_types[:transfer] && target_wallet.nil? && source_wallet.nil?
      raise ArgumentError,'Target Wallet and Source Wallet for Transfer Transaction could not be empty'
    end
  end
end
