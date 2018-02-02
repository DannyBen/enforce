require 'simplecov'
SimpleCov.start

require 'rubygems'
require 'bundler'
Bundler.require :default, :development

# ENV['ENFORCE_HOME'] = 'spec/scripts'

include Enforce
