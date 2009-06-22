
require 'rubygems'
require 'sinatra'
require 'EC2'

$: << './OpenNebulaApi'

require 'OpenNebula'

require 'pp'

include OpenNebula

ACCESS_KEY_ID = 'jfontan'
SECRET_ACCESS_KEY = 'opennebula'
SERVER = '127.0.0.1'
PORT = 4567

def get_user(name)
    user=nil
    
    user_pool=UserPool.new(Client.new('jfontan:opennebula'))
    user_pool.info
    user_pool.each{|u|
        if u.name==name
            puts "yeah!"
            user=Hash.new
            user[:id]=u.id
            user[:name]=u.name
            user[:password]=u[:password]
        end
    }
    
    user
end

def authenticate(params)
    user_name=params['AWSAccessKeyId']
    user=get_user(user_name)
    
    halt 401, "User does not exist" if !user
    
    signature_params=params.reject {|key,value| key=='Signature' }
    canonical=EC2.canonical_string(signature_params, SERVER)
    signature=EC2.encode(user[:password], canonical, false)
    
    halt 401, "Bad password" if params['Signature']!=signature
end

before do
    authenticate(params)
end

post '/' do
    pp params
    
    'lero'
end
