module CategoriesHandler
  def categories_table(transaction_type)
    categories_data = @categories.select do |category|
      category[:transaction_type] == transaction_type
    end

    table = Terminal::Table.new
    table.title = transaction_type.capitalize
    table.headings = ["ID", "Category", "Total"]
    table.rows = categories_data.map do |category|
      [category[:id], category[:name], transactions_amount_sum(category)]
    end
    table
  end

  def expenses_table
    categories_table("expense")
  end

  def income_table
    categories_table("income")
  end

  def transactions_amount_sum(category)
    amounts = category[:transactions].map do |transaction|
      transaction[:amount]
    end

    amounts.sum
  end
end
