class Api::V1::WalletsController < ApplicationController

  def balance
    if (balance = @current_user.wallet.balance)
      render json: { balance: balance }
    else
      render json: { errors: 'Failed to fetch balance' }, status: :internal_server_error
    end
  end

  def deposit
    if @current_user.wallet.deposit(wallet_params[:amount])
      balance
    else
      render json: { errors: @current_user.wallet.errors }, status: :bad_request
    end
  end

  def withdraw
    if @current_user.wallet.withdraw(wallet_params[:amount])
      balance
    else
      render json: { errors: @current_user.wallet.errors }, status: :bad_request
    end
  end

  def transfer
    target = User.find(wallet_params[:target_user_id]).wallet
    if @current_user.wallet.transfer(wallet_params[:amount], target)
      balance
    else
      render json: { errors: @current_user.wallet.errors }, status: :bad_request
    end
  end

  def wallet_params
    params.permit(:amount, :target_user_id)
  end
end
