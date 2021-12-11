module CategoriesHandler
  # ---------- methods for table printing ---------- #
  def categories_table
    case @expense
    when true
      transaction_type = "expense"
      title = "Expenses"
    when false
      transaction_type = "income"
      title = "Income"
    end

    categories_data = @categories.select do |category|
      category[:transaction_type] == transaction_type
    end

    table = Terminal::Table.new
    table.title = "#{title}\n#{@date.strftime('%B %Y')}"
    table.headings = ["ID", "Category", "Total"]
    table.rows = categories_data.map do |category|
      [category[:id], category[:name], transactions_amount_sum(category[:transactions])]
    end
    table
  end

  def transactions_amount_sum(transactions)
    month_data = month_transactions(transactions)
    amounts = month_data.map do |transaction|
      transaction[:amount]
    end
    amounts.sum
  end

  def create_category
    category_data = category_form
    new_category = Services::Categories.create_category(@user[:token], category_data)
    @categories << new_category
  end

  def update_category(id)
    found_category = find_category(id)
    return puts "Invalid option" if found_category.nil?

    category_data = category_form
    updated_category = Services::Categories.update_category(@user[:token], id, category_data)
    found_category.update(updated_category)
  end

  def delete_category(id)
    begin
      Services::Categories.delete_category(@user[:token], id)
    rescue HTTParty::ResponseError
      puts "Not found"
    end
    found_category = @categories.find { |note| note[:id] == id }
    @categories.delete(found_category)
  end

  def toggle
    @expense = @expense ? false : true
    categories_table
  end

  # ---------- Date handling methods ---------- #
  def next_month_categories
    @date = @date.next_month
    categories_table
  end

  def prev_month_categories
    @date = @date.prev_month
    categories_table
  end

  def month_transactions(transactions)
    transactions.select do |transaction|
      Date.parse(transaction[:date]).month == @date.month
    end
  end
end
