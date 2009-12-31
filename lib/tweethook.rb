$:.unshift File.expand_path(File.dirname(__FILE__))

require 'typhoeus'
require 'json'

class Tweethook
  
  autoload :Search, 'tweethook/search'
  autoload :Post, 'tweethook/post'
  autoload :Result, 'tweethook/result'
  
  def self.user
    ENV['TWEETHOOK_API_USER']
  end
  
  def self.password
    ENV['TWEETHOOK_API_PASS']
  end
  
  def self.signature
    ENV['TWEETHOOK_SIGNATURE']
  end
  
  def self.post(path,params)
    response = Typhoeus::Request.post(Tweethook.url(path),
      :params => params)
    response.body.empty? ? nil : JSON.parse(response.body)
  end
  
  def self.get(path,*params)
    params = params.empty? ? nil : params.first
    response = Typhoeus::Request.get(Tweethook.url(path), :params => params)
    return nil if response.code.eql?(403)
    result = JSON.parse(response.body)    
  end
  
  
  def self.url(path)
    "https://#{Tweethook.user}:#{Tweethook.password}@api.tweethook.com#{path}"
  end
  
end