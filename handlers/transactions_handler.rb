module TransactionsHandler
  def transactions_table(category_id)
    current_category = find_category(category_id)
    transactions_data = month_transactions(@transactions)
    transactions_data.sort_by! { |tr| tr[:date] }

    table = Terminal::Table.new
    table.title = "#{current_category[:name]}\n#{@date.strftime('%B %Y')}"
    table.headings = ["ID", "Date", "Amount", "Notes"]
    table.rows = transactions_data.map do |transaction|
      [transaction[:id], transaction_formated_date(transaction[:date]), transaction[:amount], transaction[:notes]]
    end
    table
  end

  def transaction_formated_date(date_string)
    date = Date.parse(date_string)
    date.strftime("%a, %b %-d")
  end

  def add_transaction(category_id)
    category = find_category(category_id)
    return puts "Invalid option" if category.nil?

    transaction_data = transaction_form
    new_transaction = Services::Transactions.create_transaction(@user[:token], category_id, transaction_data)
    category[:transactions] << new_transaction
    @transactions = category[:transactions]
  end

  def update_transaction(category_id, id)
    found_transaction = @transactions.find { |tr| tr[:id] == id }
    return puts "Invalid option" if found_transaction.nil?

    transaction_data = transaction_form
    transaction_data[:notes] = found_transaction[:notes] if transaction_data[:notes].nil?

    updated_transaction = Services::Transactions.update_transaction(@user[:token], category_id, id, transaction_data)
    found_transaction.update(updated_transaction)

    current_category = find_category(category_id)
    current_category[:transactions] = @transactions
  end

  def delete_transaction(category_id, id)
    begin
      Services::Transactions.delete_transaction(@user[:token], category_id, id)
    rescue HTTParty::ResponseError
      puts "Not found"
    end
    found_transaction = @transactions.find { |tr| tr[:id] == id }
    @transactions.delete(found_transaction)
    current_category = find_category(category_id)
    current_category[:transactions] = @transactions
  end

  def next_month_transactions(category_id)
    @date = @date.next_month
    transactions_table(category_id)
  end

  def prev_month_transactions(category_id)
    @date = @date.prev_month
    transactions_table(category_id)
  end
end
