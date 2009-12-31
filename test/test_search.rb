require 'helper'

class TestSearch < Test::Unit::TestCase
    context "instantiating Search with parsed JSON from API" do
      subject { @search }
      setup do 
        @json = '{
                "id": 12560300,
                "search": "\"hello world\"",
                "webhook": "http:\/\/example.com\/webhook.php",
                "active": "1",
                "format": "post"
            }'
        @parsed_json = JSON.parse(@json)    
        @search = Tweethook::Search.new(@parsed_json)
      end
      
      should 'save id in accessible instance variable' do
        assert @search.id.eql?(@parsed_json['id'])
      end
      
      should 'save search in accessible instance variable' do
        assert @search.search.eql?(@parsed_json['search'])
      end
      
      should 'save webhook in accessible instance variable' do
        assert @search.webhook.eql?(@parsed_json['webhook'])
      end
      
      should 'save active in acessible instance variable as boolean value' do
        assert @search.active.eql?(true)
      end
      
    end
    
    context "instantiating Search with Hash with symbol keys" do
      
      subject { @search }
      setup do 
        @hash = {
          :id => 1256033,
          :search => 'hello world',
          :webhook => 'http://somewhere.com',
          :active => true,
          :format => "post"
        }
        @search = Tweethook::Search.new(@hash)
      end
      
      should 'save :id in accessible instance variable' do
        assert @search.id.eql?(@hash[:id])
      end
      
      should 'save :search in accessible instance variable' do
        assert @search.search.eql?(@hash[:search])
      end
      
      should 'save :webhook in accessible instance variable' do
        assert @search.webhook.eql?(@hash[:webhook])
      end
      
    end
    
    context "saving a new Search record" do
      subject {@search}
      setup do 
        @args = {:search => 'monkey', :webhook => 'http://there.com'}
        @search = Tweethook::Search.new(@args)
        @search.save
      end
      
      should "have an id" do
        assert_not_nil @search.id
        @search.destroy
      end
    end
    
    
    context "creating a new Search record" do
      
      subject { @search }
      
      setup do 
        @query = 'monkey'
        @args = {:webhook => 'http://there.com'}
        @search = Tweethook::Search.create(@query,@args)
      end
      
      should "have an id" do
        assert_not_nil @search.id
        @search.destroy
      end
      
      
    end

end
