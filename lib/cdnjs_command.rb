require 'open-uri'
require 'fileutils'
require 'json'

CDNJS_VERSION = "0.0.4"

module Params;
  def extract(what)   i = index(what) and slice!(i, 2)[1] end;
  def first_is(what)  shift  if what.include?(self.first); end
  def self.[](*what)  what.extend Params; end
  def ===(argv)       argv.first_is(self); end
end

# ============================================================================

module Fetcher
  CACHE_PATH = "~/.cache/cdnjs"

  def self.fetch(url)
    return cache_for(url)  if cached?(url)

    tip "Fetching #{url}..."
    output = open(url).read

    FileUtils.mkdir_p File.expand_path(CACHE_PATH)
    File.open(cache_path_for(url), 'w') { |f| f.write output }
    output
  rescue => e
    tip "Unable to fetch (#{e.class.name}: #{e.message})."
    exit
  end

  def self.purge
    FileUtils.rm_rf File.expand_path(CACHE_PATH)
  end

  def self.cached?(url)
    File.file? cache_path_for(url)
  end

  def self.cache_path_for(url)
    File.expand_path slug(url), CACHE_PATH
  end

  def self.cache_for(url)
    File.open(cache_path_for(url)) { |f| f.read }
  end

  def self.slug(url)
    url.gsub(/[\/:]/, '_')
  end
end

class Package
  INDEX_URL = 'http://cdnjs.com/packages.json'

  attr_reader :data, :name, :version, :description, :homepage,
              :maintainers, :repositories

  def initialize(hash)
    @data = hash
    @name         = hash['name'].gsub(/\.js$/, '')
    @version      = hash['version']
    @description  = hash['description']
    @homepage     = hash['homepage']
    @filename     = hash['filename']
    @maintainers  = hash['maintainers']
    @repositories = hash['repositories']
  end

  def basename
    "#{name}-#{version}.js"
  end

  def url
    if @filename =~ /^http/
      @filename
    else
      "http://ajax.cdnjs.com/ajax/libs/#{data['name']}/#{version}/#{@filename}"
    end
  end

  # @return Array of {Package}s
  def self.all
    packages = JSON.parse(fetch(INDEX_URL))['packages']
    packages.delete(Hash.new)
    packages
      .map { |hash| Package.new(hash) }
      .sort_by { |pkg| pkg.name }
  end

  def self.fetch(url)
    Fetcher.fetch(INDEX_URL).force_encoding('utf-8')
  end

  def self.[](id)
    all.detect { |pkg| pkg.name == id } ||
    all.detect { |pkg| pkg.name[0...id.size] == id }
  end
end

# ============================================================================
# Helpers

def tip(message)
  $stderr.write "#{message}\n"
end

def invalid_usage(usage="cdnjs --help")
  puts "Invalid usage."
  puts "Try: #{usage.gsub(/^cdnjs/, File.basename($0))}"
  exit
end

def get_package(id)
  Package[id] or begin
    tip "Package not found."
    tip "For a list of all packages, see: cdnjs list"
    exit
  end
end

def show_help
  tip "Usage:"
  tip "  cdnjs NAME       - Download specific package"
  tip ""
  tip "Other commands:"
  tip "  cdnjs list       - List available packages"
  tip "  cdnjs info NAME  - Show package info"
  tip "  cdnjs html NAME  - Show HTML snippet to include given package"
  tip "  cdnjs url NAME   - Show the URL for the given package"
  tip "  cdnjs update     - Updates the package cache"
  tip ""
  tip "You may also use the first letters of each command; e.g., `cdnjs i jquery`."
  tip "Here are some common examples:"
  tip ""
  tip "  $ cdnjs jquery"
  tip "  $ echo `cdnjs h underscore` >> index.html"
  tip ""
end


