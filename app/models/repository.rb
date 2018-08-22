class Repository
  def initialize(raw_repo)
    @name = raw_repo[:name]
    @owner = raw_repo[:owner][:login]
    @url = raw_repo[:url]
    @created_at = raw_repo[:created_at]
    @updated_at = raw_repo[:updated_at]
  end
end
