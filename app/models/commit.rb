class Commit
  attr_reader :repo_name,
              :sha_key,
              :message,
              :author,
              :created_at
              
  def initialize(author, repo_name, sha_key, message, created_at)
    @author = author
    @repo_name = repo_name
    @sha_key = sha_key
    @message = message
    @created_at = DateTime.parse(created_at)
  end
end
