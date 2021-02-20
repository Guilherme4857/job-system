class Employees::HomeController < ApplicationController
  before_action :authenticate_employee!
  def index    
    @company = current_employee.company
  end
end