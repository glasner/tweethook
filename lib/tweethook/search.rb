#15585675

class Tweethook::Search
  
  # create a new search at Tweethook
  # Tweethook::Search.create('monkey', :post_to => 'http://where.com/callback' )
  def self.create(query,args)
    args.merge!({:query => query})
    search = new(args)
    search.save
  end
  
  def self.find(id)
    response = Typhoeus::Request.get(Tweethook.url('/info.json'), :params => {:id => id})
    return nil if response.code.eql?(403)
    result = JSON.parse(response.body).first
    new(result)
  end
  
  def initialize(args)
    @id = args[:id] || args['id']
    @query = args[:query] || args['search']
    @post_to = args[:post_to] || args['webhook']
    @active = args[:active] || args['active'] || true    
  end 
  
  def save
    response = Typhoeus::Request.post(Tweethook.url("/create.json"),
      :params => {:search => @query, :webhook => @post_to, :active => @active})
    @id = response.body.empty? ? nil : JSON.parse(response.body).first['id']
    self
  end 
  
  def destroy
    response = Typhoeus::Request.post(Tweethook.url('/destroy.json'), :params => {:id => @id})
    return if response.body.empty?
    response = JSON.parse(response.body)
    self.id = nil if response.first['id'].eql?(@id)    
  end
  
  
end