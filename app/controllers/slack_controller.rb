require 'net/http'
require 'uri'
require 'json'

class SlackController < ApplicationController
  def index
    id_compare = "#{request.params[:project_id]}"
    uri = URI("#{root_url}/api/v3/projects")
    req = Net::HTTP::Get.new(uri)
    req['X-Requested-With'] = "XMLHttpRequest"
    res = Net::HTTP.start(uri.hostname, uri.port) { |http|
      http.request(req)
    }
    @body = JSON.parse(res.body)
    @project_id = @body["_embedded"]["elements"].find { |h| h["identifier"] == id_compare }["_links"]["self"]["href"]

    uri = URI("#{root_url}/api/v3/queries")
    req = Net::HTTP::Get.new(uri)
    req['X-Requested-With'] = "XMLHttpRequest"
    res = Net::HTTP.start(uri.hostname, uri.port) { |http|
      http.request(req)
    }
    @body = JSON.parse(res.body)
    @query_version = @body["_embedded"]["elements"].find { |h| h["_links"]["self"]["title"] == "Version - Sprint" && h["_links"]["project"]["href"] == @project_id }
    @link = @query_version["_links"]["results"]["href"]
    render layout: true
  end
end
