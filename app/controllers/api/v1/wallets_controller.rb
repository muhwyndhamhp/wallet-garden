# frozen_string_literal: true

module Api
  module V1
    class WalletsController < ApplicationController
      def balance
        render json: { balance: @current_user.wallet.balance }
      rescue StandardError => e
        render json: { error: e }, status: :bad_request
      end

      def deposit
        balance if @current_user.wallet.deposit(wallet_params[:amount])
      rescue StandardError => e
        render json: { error: e }, status: :bad_request
      end

      def withdraw
        balance if @current_user.wallet.withdraw(wallet_params[:amount])
      rescue StandardError => e
        render json: { errors: e }, status: :bad_request
      end

      def transfer
        target = Wallet.find(wallet_params[:target_wallet_id])
        balance if @current_user.wallet.transfer(wallet_params[:amount], target)
      rescue StandardError => e
        render json: { errors: e }, status: :bad_request
      end

      def wallet_params
        params.permit(:amount, :target_wallet_id)
      end
    end
  end
end
