class Wallet < ApplicationRecord
  belongs_to :user, polymorphic: true

  has_many :credit_transactions, class_name: 'Transaction', foreign_key: 'target_wallet_id'
  has_many :debit_transactions, class_name: 'Transaction', foreign_key: 'source_wallet_id'

  def balance
    credit_transactions.sum(:amount) - debit_transactions.sum(:amount)
  end

  def deposit(amount)
    Transaction.create(
      amount: amount,
      target_wallet: self,
      operation: Transaction.operation_types[:credit]
    )
  end

  def withdraw(amount)
    if balance < amount
      return errors.add(:base, 'Amount withdrawn more than existing balance')
    end
    Transaction.create(
      amount: amount,
      source_wallet: self,
      operation: Transaction.operation_types[:debit]
    )
  end

  def transfer(amount, target_wallet)
    if balance < amount
      return errors.add(:base, 'Amount transferred more than existing balance')
    elsif target_wallet.id == self.id
      return errors.add(:base, 'Target Wallet cannot be the same as Source Wallet')
    end
    Transaction.create(
      amount: amount,
      target_wallet: target_wallet,
      source_wallet: self,
      operation: Transaction.operation_types[:transfer]
    )
  end
end
