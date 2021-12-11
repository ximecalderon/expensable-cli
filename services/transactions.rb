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

    def self.create_transaction(token, category_id, transaction_data)
      options = {
        headers: {
          Authorization: "Token token=#{token}",
          "Content-Type": "application/json"
        },
        body: transaction_data.to_json
      }

      response = post("/#{category_id}/transactions/", options)
      raise(HTTParty::ResponseError, response) unless response.success?

      JSON.parse(response.body, symbolize_names: true)
    end

    def self.update_transaction(token, category_id, id, transaction_data)
      options = {
        headers: {
          Authorization: "Token token=#{token}",
          "Content-Type": "application/json"
        },
        body: transaction_data.to_json
      }

      response = patch("/#{category_id}/transactions/#{id}", options)
      raise HTTParty::ResponseError, response unless response.success?

      JSON.parse(response.body, symbolize_names: true)
    end

    def self.delete_transaction(token, category_id, id)
      options = {
        headers: {
          Authorization: "Token token=#{token}"
        }
      }
      response = delete("/#{category_id}/transactions/#{id}", options)
      raise HTTParty::ResponseError, response unless response.success?

      JSON.parse(response.body, symbolize_names: true) unless response.body.nil?
    end
  end
end
