class Commit
  attr_reader :repo_name,
              :sha_key,
              :message,
              :author,
              :created_at

  def initialize(info)
    @author = info[:author][:login]
    @repo_name = info[:repository][:full_name]
    @sha_key = info[:sha]
    @message = info[:commit][:message]
    @created_at = DateTime.parse(info[:commit][:author][:date])
  end
end
