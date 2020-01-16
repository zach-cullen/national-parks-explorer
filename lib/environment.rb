require 'dotenv/load'
require 'pry'
require 'rest-client'
require 'json'

require_relative './national_parks_explorer/version.rb'
require_relative './national_parks_explorer/fixtures.rb'
require_relative './national_parks_explorer/cli.rb'
require_relative './national_parks_explorer/api-adapter.rb'