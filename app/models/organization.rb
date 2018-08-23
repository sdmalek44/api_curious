class Organization
  attr_reader :login,
              :url,
              :description
              
  def initialize(org_info)
    @login = org_info[:login]
    @url = org_info[:url]
    @description = org_info[:description]
  end
end
