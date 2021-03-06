class Tweethook::Result
  
  attr_accessor :user, :tweet, :usrimg, :tid, :tstamp, :unix_tstamp, :is_reply, :is_retweet, :mentions, :source, :sourcelink, :search_query
  
  def initialize(args)
    args.each { |key,value| instance_variable_set("@#{key}",value)  }
    change_boolean_values    
  end
  
  def change_boolean_values
    @is_reply = !@is_reply.zero?
    @is_retweet = !@is_retweet.zero?
  end
  
  def reply?
    @is_reply
  end
  
  def retweet?
    @is_retweet
  end
  
end
