class User < ApplicationRecord
  has_one :wallet, as: :user, dependent: :destroy

  has_secure_password
  validates :email, presence: true, uniqueness: true
  after_create :create_user_wallet

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

  def create_user_wallet
    self.wallet = Wallet.create if wallet.nil?
  end
end
