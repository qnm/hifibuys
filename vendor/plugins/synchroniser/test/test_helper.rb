ENV['RAILS_ENV'] = 'test'
ENV['RAILS_ROOT'] ||= File.dirname(__FILE__) + '/../../../..'

require File.expand_path(File.join(ENV['RAILS_ROOT'], 'config/environment.rb'))
require 'test_helper.rb'
require 'rubygems'
require 'test/unit'
require 'active_support'
require 'active_support/test_case'

#require 'test/synchroniser_test.rb'
