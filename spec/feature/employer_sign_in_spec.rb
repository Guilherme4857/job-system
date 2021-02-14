require 'rails_helper'

feature 'Employer sign in' do
  scenario 'sign in' do
    employee = Employee.create!(email: 'joao@campuscode.com', password: '123456')
    
    click
  end
end