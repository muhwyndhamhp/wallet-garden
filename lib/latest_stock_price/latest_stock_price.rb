# frozen_string_literal: true

module LatestStockPrice
  class API
    require 'uri'
    require 'net/http'

    def initialize(api_key)
      @api_key = api_key
      @base_url = URI.parse('https://latest-stock-price.p.rapidapi.com')
      @host_name = 'latest-stock-price.p.rapidapi.com'
    end

    INDICES = ['NIFTY 50', 'NIFTY NEXT 50', 'NIFTY 100', 'NIFTY 200', 'NIFTY 500',
               'NIFTY MIDCAP 50', 'NIFTY MIDCAP 100', 'NIFTY MIDCAP 150',
               'NIFTY SMLCAP 50', 'NIFTY SMLCAP 100', 'NIFTY SMLCAP 250',
               'NIFTY MIDSMP 400', 'NIFTY BANK', 'NIFTY AUTO',
               'NIFTY FINSRV25 50', 'NIFTY FIN SERVICE',
               'NIFTY FMCG', 'NIFTY IT', 'NIFTY MEDIA', 'NIFTY METAL',
               'NIFTY INFRA', 'NIFTY ENERGY', 'NIFTY PHARMA',
               'NIFTY PSU BANK', 'NIFTY PVT BANK'].freeze

    def price_all
      url = URI.join(@base_url, '/any')
      make_request(url)
    end

    def prices(index)
      validate_index(index)

      url = URI.join(@base_url, '/price')
      url.query = "Indices=#{index}"

      make_request(url)
    end

    def price(index)
      validate_index(index)

      url = URI.join(@base_url, '/price')
      url.query = "Indices=#{index}"

      response = make_request(url)

      JSON.parse(response)[0]
    end

    private

    def validate_index(index)
      return if INDICES.find { |entry| entry == index }

      raise ArgumentError, 'Invalid index parameter'
    end

    def make_request(url)
      request = Net::HTTP::Get.new(url)
      request['X-RapidAPI-Key'] = @api_key
      request['X-RapidAPI-Host'] = @host_name

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      response = http.request(request)
      response.read_body
    end
  end
end
