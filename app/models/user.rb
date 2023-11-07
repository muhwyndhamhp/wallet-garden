# frozen_string_literal: true

class User < ApplicationRecord
  include WalletConcern
  has_one :wallet, as: :user, dependent: :destroy

  has_secure_password
  validates :email, presence: true, uniqueness: true
  after_create :create_wallet

  def regenerate_auth_token
    update(auth_token: generate_unique_auth_token)
  end

  def invalidate_auth_token
    update(auth_token: nil)
  end

  private

  def generate_unique_auth_token
    loop do
      token = SecureRandom.urlsafe_base64
      break token unless self.class.exists?(auth_token: token)
    end
  end
end
