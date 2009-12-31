class Tweethook::Search
  
  # create a new search at Tweethook
  # Tweethook::Search.create('monkey', :webhook => 'http://where.com/callback' )
  def self.create(search,args)
    args.merge!({:search => seach})
    search = new(args)
    search.save
  end
  
  def self.find(id)
    response = Tweethook.get('/info.json', :id => id)
    return nil if response.nil?
    new(response.first)
  end
  
  attr_accessor :id, :search, :webhook, :active
  
  def initialize(args)
    # change text keys to symbols
    if args.any? { |arg| arg.is_a?(String)  }
      args = args.inject({}) { |output,array| key,value = array; output[key.to_sym] = value;output  }
    end    
    # setup instance variable for every arg
    args.each_with_key { |key,value| instance_variable_set("@#{key}",value)  }
    @active = true if @active.nil?      
  end 
  
  def save
    response = Tweethook.post('/create.json',:search => @search, :webhook => @webhook, :active => @active)
    return nil if response.nil?
    @id = response.first['id']
    self
  end 
  
  def new_record?
    not @id.nil?
  end
  
  def destroy
    response = Tweethook.post('/destroy.json',:id => @id)
    return nil if response.nil?
    self.id = nil if response.first['id'].eql?(@id)    
  end
  
  
end