require 'net/http'
require 'uri'
require 'json'
require 'logger'
require 'active_support'
require 'active_support/core_ext'
require 'news-api'

class RestCommentsController < ApplicationController
  def create
    restaurant = Restaurant.find(params[:restaurant_id])
    comment = current_user.rest_comments.new(rest_comment_params)
    comment.restaurant_id = restaurant.id
    comment.score = Language.get_data(rest_comment_params[:comment])
    if comment.save
      redirect_to restaurant_rest_comments_path(restaurant)
    else
      @restaurant = Restaurant.find(params[:restaurant_id])
      array = { keyid: Rails.application.credentials.grunavi[:api_key],
                id: @restaurant.shop_id }
      # attr_accessor :freeword
      logger = Logger.new('./webapi.log')

      params = URI.encode_www_form(array)

      uri = URI.parse("https://api.gnavi.co.jp/RestSearchAPI/v3/?#{params}")

      begin
        response = Net::HTTP.new(uri.host, uri.port).yield_self do |http|
          http.use_ssl = true
          http.open_timeout = 5
          http.read_timeout = 30
          http.get(uri.request_uri)
        end

        case response
        when Net::HTTPSuccess

          hash = JSON.parse(response.body, symbolize_names: true)

          @hash = hash[:rest]

          # puts @hash ["rest"][0]["name"]
          # puts @hash ["rest"][2]["name"]
        when Net::HTTPRedirection
          logger.warn("Redirection: code=#{response.code} message=#{response.message}")
        else
          logger.error("HTTP ERROR: code=#{response.code} message=#{response.message}")
        end
      rescue IOError => e
        logger.error(e.message)
      rescue TimeoutError => e
        logger.error(e.message)
      rescue JSON::ParserError => e
        logger.error(e.message)
      rescue StandardError => e
        logger.error(e.message)
      end
      newsapi = News.new("987e2ac50feb42b6884e30ce7b13c2e5")
      @moments = newsapi.get_everything(q: URI.encode(@restaurant[:name]),language: 'jp', sortBy: 'popularity')
      @rest_comment = RestComment.new
      render 'restaurants/show'
    end
  end

  def show
    @restaurant = Restaurant.find(params[:restaurant_id])
    @score = @restaurant.rest_comments.all.sum(:score)
    if @score >= 2
      @restaurant.good_score = @score.floor
      @restaurant.save
    end
  end

  private
  def rest_comment_params
      params.require(:rest_comment).permit(:user_id,:restaurant_id,:comment)
  end

end
