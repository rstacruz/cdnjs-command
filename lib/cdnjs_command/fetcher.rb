module CdnjsCommand::Fetcher
  CACHE_PATH = "~/.cache/cdnjs"

  extend CdnjsCommand::Helpers

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
