require "httparty"
require "json"
module Services
  class Categories
    include HTTParty

    base_uri("https://expensable-api.herokuapp.com/categories")

    def self.index_categories(token)
      options = {
        headers: { Authorization: "Token token=#{token}" }
      }

      response = get("/", options)
      raise(HTTParty::ResponseError, response) unless response.success?

      JSON.parse(response.body, symbolize_names: true)
    end

    #def self.create_category(token, category_data)
    #  options = {
    #    headers: {
    #      Authorization: "Token token=#{token}",
    #      "Content-Type": "application/json"
    #    },
    #    body: category_data.to_json
    #  }
#
    #  response = post("/", options)
    #  raise(HTTParty::ResponseError, response) unless response.success?
#
    #  JSON.parse(response.body, symbolize_names: true)
    #end
#
    #def self.update_category(token, id, category_data)
    #  options = {
    #    headers: {
    #      Authorization: "Token token=#{token}",
    #      "Content-Type": "application/json"
    #    },
    #    body: category_data.to_json
    #  }
#
    #  response = patch("/#{id}", options)
    #  raise HTTParty::ResponseError, response unless response.success?
#
    #  JSON.parse(response.body, symbolize_names: true)
    #end
#
    #def self.delete_category(token, id)
    #  options = {
    #    headers: {
    #      Authorization: "Token token=#{token}"
    #    }
    #  }
#
    #  response = delete("/#{id}", options)
    #  raise HTTParty::ResponseError, response unless response.success?
#
    #  JSON.parse(response.body, symbolize_names: true) unless response.body.nil?
    #end
  end
end
