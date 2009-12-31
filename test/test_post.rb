require 'helper'
require 'time'

class TestPost < Test::Unit::TestCase
    context "instantiating TestPost with valid JSON" do
      subject { @post }
      setup do 
        @json = '{
          "status_count": 2,
          "signature": "XXXXXXXXXXXXXXXXXXXXXXXX",
          "time": 1253055217,
          "results": [{
              "user": "deputy5765",
              "tweet": "@Lu_Guz You will have to install a Twitter application in Facebook. Log in, search Twitter, install the app, then enter the info #geeksquad",
              "usrimg": "http:\/\/a3.twimg.com\/profile_images\/107659093\/0_normal.jpg",
              "tid": 4015703048,
              "tstamp": "Tue, 15 Sep 2009 22:53:12 +0000",
              "unix_tstamp": 1253055192,
              "is_reply": 1,
              "is_retweet": 0,
              "mentions": "Lu_Guz",
              "source": "Tweetie",
              "sourcelink": "http:\/\/www.atebits.com\/",
              "search_query": "twitter"
          },
          {
              "user": "heatherkentart",
              "tweet": "@k8otomato - Thanks, I will definitely try later. I will also postpone any negative opinions of Twitter. :D",
              "usrimg": "http:\/\/a3.twimg.com\/profile_images\/417128285\/me_normal.jpg",
              "tid": 4015703318,
              "tstamp": "Tue, 15 Sep 2009 22:53:11 +0000",
              "unix_tstamp": 1253055191,
              "is_reply": 1,
              "is_retweet": 0,
              "mentions": "k8otomato",
              "source": "web",
              "sourcelink": "http:\/\/twitter.com\/",
              "search_query": "twitter"
          }	
        ]}'
        @parsed_json = JSON.parse(@json)
        @post = Tweethook::Post.new(@json)
      end



      should "take json payload" do
        assert subject
      end

      should "have the same size as given json['results']" do
        assert subject.size.eql?(@parsed_json['results'].size)
      end

      should "parse json['results'] into hash of Result objects" do
        assert subject.all? { |element| element.is_a?(Tweethook::Result)  }
      end

      should "save post signature into accessible instance variable" do
        assert subject.signature.eql?(@parsed_json['signature'])
      end

      should "save post time into accessible instance variable" do
        assert subject.time.eql?(Time.at(@parsed_json['time']))
      end
    end

end
