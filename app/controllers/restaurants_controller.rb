require 'net/http'
require 'uri'
require 'json'
require 'logger'
require 'active_support'
require 'active_support/core_ext'
require 'news-api'

class RestaurantsController < ApplicationController
  def index
      newsapi = News.new("987e2ac50feb42b6884e30ce7b13c2e5")
      @ramens = newsapi.get_everything(q: URI.encode('ラーメン'))
      @yakinikus = newsapi.get_everything(q: URI.encode('焼肉'))
      @itarians = newsapi.get_everything(q: URI.encode('イタリアン'))

  end

 def search
    freeword = %W[#{params[:freeword1]} #{params[:freeword2]}].join(',')
    hairetu = { keyid: Rails.application.credentials.grunavi[:api_key],
                name: params[:name],
                freeword: freeword }


    # attr_accessor :freeword
    logger = Logger.new('./webapi.log')

    # key = ENV['GNAVI_API_KEY']
    # key = 'eeaec53f40fbe0b0f103d3dc86b1d94b'
    params = URI.encode_www_form(hairetu)

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
    hairetu = { keyid: Rails.application.credentials.grunavi[:api_key],
                id: params[:id] }

    # attr_accessor :freeword
    logger = Logger.new('./webapi.log')

    # key = ENV['GNAVI_API_KEY']
    # key = 'eeaec53f40fbe0b0f103d3dc86b1d94b'
    params = URI.encode_www_form(hairetu)

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



    @restaurant = Restaurant.find_by(shop_id: @hash[0][:id])
    if @restaurant == nil
      @moments = newsapi.get_everything(q: URI.encode(@hash[0][:name]))
      @restaurant = Restaurant.new
      @restaurant.name = @hash[0][:name]
      @restaurant.shop_id = @hash[0][:id]
      @restaurant.image = @hash[0][:image_url][:shop_image1]
      @restaurant.genre = @hash[0][:category]
      @restaurant.save
    else
      @moments = newsapi.get_everything(q: URI.encode(@restaurant[:name]))
    end
    @rest_comment = RestComment.new
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :shop_id, :genre, :image)
  end

end
