require 'open-uri'
require 'fileutils'
require 'json'

CDNJS_VERSION = "0.0.6"

module CdnjsCommand
  autoload :Params,  File.expand_path('../cdnjs_command/params', __FILE__)
  autoload :Fetcher, File.expand_path('../cdnjs_command/fetcher', __FILE__)
  autoload :Package, File.expand_path('../cdnjs_command/package', __FILE__)
  autoload :Helpers, File.expand_path('../cdnjs_command/helpers', __FILE__)
end
