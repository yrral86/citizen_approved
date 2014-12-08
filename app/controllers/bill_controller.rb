class BillController < ApplicationController
  def current
    @bills = Bill.current
  end
end
