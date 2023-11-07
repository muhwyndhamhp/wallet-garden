# frozen_string_literal: true

class Team < ApplicationRecord
  include WalletConcern
  has_one :wallet, as: :user, dependent: :destroy
  after_create :create_wallet
end
