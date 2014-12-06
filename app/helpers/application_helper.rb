module ApplicationHelper
  def states_helper
    [['West Virginia', 'WV'],
     ['Maryland', 'MD'],
     ['California', 'CA']]
  end

  def options_helper(collection)
    collection.map do |c|
      [c.option_name, c.id]
    end
  end
end
