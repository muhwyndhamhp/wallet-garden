# frozen_string_literal: true

module Api
  module V1
    class StocksController < ApplicationController
      require './lib/latest_stock_price/latest_stock_price'

      def initialize
        super
        @price_api = LatestStockPrice::API.new(ENV['RAPID_API_KEY'])
      end

      def prices
        res = @price_api.prices(params[:index])
        render json: res.as_json, status: :ok
      rescue StandardError => e
        render json: { error: e }, status: :bad_request
      end

      def latest_price
        res = @price_api.price(params[:index])
        render json: res.as_json, status: :ok
      rescue StandardError => e
        render json: { error: e }, status: :bad_request
      end
    end
  end
end
