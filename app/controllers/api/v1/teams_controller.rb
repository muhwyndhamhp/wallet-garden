# frozen_string_literal: true

module Api
  module V1
    class TeamsController < ApplicationController
      def create
        if (res = Team.create(team_params))
          render json: { message: 'Teams created successfully!' }, status: :created
        else
          render json: { errors: res.errors }, status: :bad_request
        end
      end

      def balance
        team = Team.find(team_params[:id])
        render json: { balance: team.wallet.balance }
      rescue StandardError => e
        render json: { error: e }, status: :bad_request
      end

      def deposit
        team = Team.find(team_params[:id])
        balance if team.wallet.deposit(team_params[:amount])
      rescue StandardError => e
        render json: { error: e }, status: :bad_request
      end

      def withdraw
        team = Team.find(team_params[:id])
        balance if team.wallet.withdraw(team_params[:amount])
      rescue StandardError => e
        render json: { error: e }, status: :bad_request
      end

      def transfer
        team = Team.find(team_params[:id])
        target = Wallet.find(team_params[:target_wallet_id])
        balance if team.wallet.transfer(team_params[:amount], target)
      rescue StandardError => e
        render json: { error: e }, status: :bad_request
      end

      def team_params
        params.permit(:id, :name, :amount, :target_wallet_id)
      end
    end
  end
end
