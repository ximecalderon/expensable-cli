module TransactionsHandler
  def transactions_table(category_id)
    transactions_data = month_transactions(@transactions)

    table = Terminal::Table.new
    table.title = "#{category_name(category_id)}\n#{@date.strftime('%B %Y')}"
    table.headings = ["ID", "Date", "Amount", "Notes"]
    table.rows = transactions_data.map do |transaction|
      [transaction[:id], transaction_formated_date(transaction[:date]), transaction[:amount], transaction[:notes]]
    end
    table
  end

  def category_name(category_id)
    current_category = @categories.find do |category|
      category[:id] == category_id
    end
    current_category[:name]
  end

  def transaction_formated_date(date_string)
    date = Date.parse(date_string)
    date.strftime("%a, %b %-d")
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
