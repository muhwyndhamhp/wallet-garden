# frozen_string_literal: true

module WalletConcern
  extend ActiveSupport::Concern

  def create_wallet
    self.wallet = Wallet.create if wallet.nil?
  end
end
