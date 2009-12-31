class Tweethook::Search
  
  # create a new search at Tweethook
  # Tweethook::Search.create('monkey', :webhook => 'http://where.com/callback' )
  def self.create(search,args)
    args.merge!({:search => search})
    search = new(args)
    search.save
  end
  
  def self.find(id)
    response = Tweethook.get('/info.json', :id => id)
    return nil if response.nil?
    new(response.first)
  end
  
  def self.list
    response = Tweethook.get('/list.json')
    return [] if response.nil?
    response.map { |hash| Tweethook::Search.new(hash)  }    
  end
  
  attr_accessor :id, :search, :webhook, :active
  
  def initialize(args)
    # change string keys to symbols
    if args.any? { |arg| arg.is_a?(String)  }
      args = args.inject({}) { |output,array| key,value = array; output[key.to_sym] = value;output  }
    end    
    # setup instance variable for every arg
    args.each { |key,value| instance_variable_set("@#{key}",value)  }
    
    @format ||= 'json'
    
    change_active_to_boolean
  end 
  
  def change_active_to_boolean
    # @active defaults to true
    @active = true if @active.nil?      
    # change @active to boolean value if it's an integer
    @active = !@active.to_i.zero? if @active.is_a?(String)
  end
  
  def save
    return modify unless new_record?
    response = Tweethook.post('/create.json',:search => @search, :webhook => @webhook, :active => @active)
    return nil if response.nil?
    @id = response.first['id']
    self
  end 
  
  def modify
    response = Tweethook.post('/modify.json', :id => @id, :search => @search, :webhook => @webhook, :active => @active)
    return nil if response.nil?
    self
  end
  
  def new_record?
    not @id.nil?
  end
  
  def start
    response = Tweethook.post('/start.json', :id => @id)
    return false if response.nil?
    @active = true
  end
  alias :resume :start
  
  def stop
    response = Tweethook.post('/stop.json', :id => @id)
    return false if response.nil?
    @active = false
  end
  alias :pause :stop
  
  
  def destroy
    response = Tweethook.post('/destroy.json',:id => @id)
    return false if response.nil?
    self.id = nil if response.first['id'].eql?(@id)    
  end
  
  
end