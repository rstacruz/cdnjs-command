Gem::Specification.new do |s|
  s.name = "cdnjs-command"
  s.version = "0.0.2"
  s.summary = %{Command line helper for cdnjs.com.}
  s.description = %Q{This package lets you download the popular JavaScript packages with one command, thanks to www.cdnjs.com.}
  s.authors = ["Rico Sta. Cruz"]
  s.email = ["rico@sinefunc.com"]
  s.homepage = "http://github.com/rstacruz/cdnjs-command"
  s.files = ["bin/cdnjs", "HISTORY.md", "README.md"]

  s.add_dependency "json"
end
