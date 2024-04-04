require 'net/http'

class ProductsController < ApplicationController
  before_action :verify_authenticity_token

  def create
    @product = Product.new(product_params)
    if @product.save
      notify_third_parties(@product)
      render json: @product, status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      notify_third_parties(@product)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description)
  end


  def notify_third_parties(product)
   Rails.application.config.third_party_endpoints.each do |endpoint|
      uri = URI.parse(endpoint)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = (uri.scheme == 'https')

      request = Net::HTTP::Post.new(uri.path)
      request.body = product.to_json
      request['Content-Type'] = 'application/json'

      begin
        response = http.request(request)
        puts "Successful notification to #{endpoint}: #{response.code} - #{response.message}"
      rescue StandardError => e
        puts "Error notifying #{endpoint}: #{e.message}"
      end
    end
  end

  def verify_authenticity_token
    token = request.headers['Authorization']
    secret_token = Rails.application.secrets.secret_key_base

    unless token == secret_token
      render json: { error: 'Invalid authenticity token' }, status: :unauthorized
    end
  end

end
