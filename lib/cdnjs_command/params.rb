module CdnjsCommand::Params
  def extract(what)   i = index(what) and slice!(i, 2)[1] end;
  def first_is(what)  shift  if what.include?(self.first); end
  def self.[](*what)  what.extend Params; end
  def ===(argv)       argv.first_is(self); end
end

