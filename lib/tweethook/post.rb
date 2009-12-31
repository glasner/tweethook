class Tweethook::Post < Array
  
  attr_accessor :signature, :time
  
  def initialize(json)
    hash = json.is_a?(Hash) ? json : JSON.parse(json)
    @signature = hash['signature']
    @time = Time.at(hash['time'])
    super(hash['results'].map { |result| Tweethook::Result.new(result) })
  end
  
  def valid?
    @signature.eql?(Tweethook.signature)
  end
  
  
end