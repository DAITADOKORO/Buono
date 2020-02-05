require 'net/http'
require 'uri'
require 'json'
require 'logger'
require 'active_support'
require 'active_support/core_ext'
require 'news-api'

class RestaurantsController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def index
    newsapi = News.new(Rails.application.credentials.news_key)
    @news = newsapi.get_everything(q: URI.encode('東京　グルメ　美味　店　選'),language: 'jp', sortBy: 'popularity')
    @wants = Want.all
    @repeats = Repeat.all
    @random = Restaurant.order("RANDOM()").limit(3)
    @tags = Restaurant.tag_counts_on(:tags).order('count DESC')
  end

  def tag_cloud
    @tags = Restaurant.tag_counts_on(:tags).order('count DESC')
    @restaurants = Restaurant.tagged_with(params[:tag_name])
  end

  def search
    freeword = %W[#{params[:freeword1]} #{params[:freeword2]}].join(',')
    array = { keyid: Rails.application.credentials.grunavi[:api_key],
                name: params[:name],
                freeword: freeword }
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
  end

  def show
    array = { keyid: Rails.application.credentials.grunavi[:api_key],
                id: params[:id] }
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
    newsapi = News.new(Rails.application.credentials.news_key)

    @restaurant = Restaurant.find_by(shop_id: @hash[0][:id])
    if @restaurant == nil
      @restaurant = Restaurant.new
      @restaurant.name = @hash[0][:name]
      @restaurant.shop_id = @hash[0][:id]
      @restaurant.image = @hash[0][:image_url][:shop_image1]
      @restaurant.tag_list = @hash[0][:code][:category_name_s]
      @restaurant.prefecture = @hash[0][:code][:prefname]
      @restaurant.area = @hash[0][:code][:areacode_s]
      @restaurant.latitude = @hash[0][:latitude]
      @restaurant.longitude = @hash[0][:longitude]
      @restaurant.save
    end
    binding.pry
    @moments = newsapi.get_everything(q: URI.encode("#{@restaurant.prefecture} #{@restaurant.tag_list} 美味 店　選") ,language: 'jp', sortBy: 'popularity')
    hoge = Restaurant.where.not(id: @restaurant[:id])
    @neighbors = hoge.where(area: @restaurant[:area]).order("RANDOM()").limit(4)
    @rest_comment = RestComment.new
  end

  def marker
    lat = Range.new(*[params["north"], params["south"]].sort)
    lng = Range.new(*[params["east"], params["west"]].sort)
    @map = params["map"]
    # データ取得
    @locations = Restaurant.where(latitude: lat, longitude: lng)
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :shop_id, :tag_list, :image, :prefecture, :area, :latitude, :longitude)
  end

end
