require "httparty"
require "json"

module Services
  class Transactions
    include HTTParty

    base_uri("https://expensable-api.herokuapp.com/categories")

    def self.index_transactions(token, category_id)
      options = {
        headers: { Authorization: "Token token=#{token}" }
      }

      response = get("/#{category_id}/transactions/", options)
      raise(HTTParty::ResponseError, response) unless response.success?

      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
