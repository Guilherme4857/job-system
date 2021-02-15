require 'rails_helper'

feature 'Employer register yourself' do
  scenario 'since root path' do
    visit root_path
    click_on 'Entrar como funcionário de empresa'
    click_on 'Inscrever-se'
    within('form') do
      fill_in 'E-mail', with: 'joao@campuscode.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirme sua senha', with: '123456'
      click_on 'Inscrever-se'        
    end

    expect(current_path).to eq root_path
  end
end