# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

#Fix picture / carrierwave crash
require 'carrierwave/orm/activerecord'