require 'rails_helper'

feature 'Employer admin register company' do
  scenario 'successfully' do
    company = {name: 'Campus Code', cnpj: '33.222.111/0050-46', 
               site: 'campuscode.com', company_history: 'Vem crescendo /
               bastante', company_address: {public_place: 'Rua Cícero, 41', 
               district: 'Anhembi', city: 'São Paulo', zip_code: '41002-241'}}

    
    visit new_company_path
    fill_in 'Nome', with: company[:name]
    fill_in 'CNPJ', with: company[:cnpj]
    fill_in 'Site', with: company[:site]
    fill_in 'História da Empresa', with: company[:company_history]
    fill_in 'Rua', with: company[:company_address][:public_place]
    fill_in 'Bairro', with: company[:company_address][:district]
    fill_in 'Cidade', with: company[:company_address][:city]
    fill_in 'CEP', with: company[:company_address][:zip_code]
    click_on 'Criar Empresa'

    expect(current_path).to eq root_path
  end
end