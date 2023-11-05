class Api::V1::TeamsController < ApplicationController
  def create
    if (res = Team.create(team_params))
      render json: { message: 'Teams created successfully!' }, status: :created
    else
      render json: { errors: res.errors }, status: :bad_request
    end
  end

  def balance
    team = Team.find(team_params[:id])
    if (balance = team.wallet.balance)
      render json: { balance: balance }
    else
      render json: { errors: 'Failed to fetch balance' }, status: :internal_server_error
    end
  end

  def deposit
    team = Team.find(team_params[:id])
    if (res = team.wallet.deposit(team_params[:amount]))
      balance
    else
      render json: { errors: res.errors }, status: :bad_request
    end
  end

  def withdraw
    team = Team.find(team_params[:id])
    if (res = team.wallet.withdraw(team_params[:amount]))
      balance
    else
      render json: { errors: res.errors }, status: :bad_request
    end
  end

  def transfer
    team = Team.find(team_params[:id])
    target = Wallet.find(team_params[:target_wallet_id])
    if team.wallet.transfer(team_params[:amount], target)
      balance
    else
      render json: { errors: team.wallet.errors }, status: :bad_request
    end
  end

  def team_params
    params.permit(:id, :name, :amount, :target_wallet_id)
  end
end
