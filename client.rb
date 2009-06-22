#!/usr/bin/ruby

require 'pp'

require 'rubygems'
require 'EC2'


ACCESS_KEY_ID = 'jfontan'
#SECRET_ACCESS_KEY = 'opennebula'
SECRET_ACCESS_KEY = '4478db59d30855454ece114e8ccfa5563d21c9bd'
SERVER = '127.0.0.1'
PORT = 4567

base=EC2::Base.new(
    :access_key_id => ACCESS_KEY_ID,
    :secret_access_key => SECRET_ACCESS_KEY,
    :server => SERVER,
    :port => PORT,
    :use_ssl => false
)

pp base.describe_images

