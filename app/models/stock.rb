class Stock < ApplicationRecord
  has_one :wallet, as: :user, dependent: :destroy
end
