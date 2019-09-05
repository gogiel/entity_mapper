# typed: strong

module EntityMapper
  sig { params(block: T.proc.params(arg0: Mapping::DSL).void).returns(Mapping::Model) }
  def self.map(&block)
  end
end
