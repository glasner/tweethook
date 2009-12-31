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
  
  
  def self.url(path)
    "https://#{Tweethook.user}:#{Tweethook.password}@api.tweethook.com#{path}"
  end
  
end