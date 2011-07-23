module CdnjsCommand::Helpers
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
end
