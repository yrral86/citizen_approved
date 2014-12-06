class DistrictsController < ApplicationController
  def options
    render partial: 'options', locals: {state_code: params['state_code']}
  end
end
