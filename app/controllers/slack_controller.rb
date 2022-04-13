require 'net/http'
require 'uri'
require 'json'

class SlackController < ApplicationController
  def index
    uri = URI('http://3.130.0.185:8080/pmoDev/api/v3/queries')
    req = Net::HTTP::Get.new(uri)
    req.basic_auth 'apikey', '720612c4e93bafff08a909592ae3e0fa793a32633fc078890b425d1f68608d02'
    res = Net::HTTP.start(uri.hostname, uri.port) { |http|
      http.request(req)
    }
    @body = JSON.parse(res.body)
    render layout: true
  end
end
