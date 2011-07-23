class CdnjsCommand::Package
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
