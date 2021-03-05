require 'rails_helper'

feature 'Employer admin register company' do  
  scenario 'successfully' do
    employee =  Employee.create!(
      email: 'henrique@campuscode.com.br', password: '123456',
      cpf: '12.345.678/9'
    )  
    employee.admin!
    login_as employee, scope: :employee
    company = {
      name: 'Campus Code', cnpj: '33.222.111/0050-46', 
      site: 'http://www.campuscode.com.br',
      company_history: 'Vem crescendo bastante', 
      linkedin:'http://www.linkedin.com/school/campus-code/',
      facebook: 'http://www.facebook.com/CampusCodeBr/', 
      twitter: 'http://www.twitter.com/campuscodebr',
      company_address: {public_place: 'Rua Cícero, 41', 
      district: 'Anhembi', city: 'São Paulo', zip_code: '41002-241'}
    }
    
    visit new_employees_company_path
    within('form') do
      fill_in 'Nome', with: company[:name]
      attach_file 'Logomarca', Rails.root.join(
        'app', 'assets','images', 'logomarcas', 'campuscode.png'
      )
      fill_in 'CNPJ', with: company[:cnpj]
      fill_in 'Site', with: company[:site]
      fill_in 'História da Empresa', with: company[:company_history]
      fill_in  'Rede Social 1', with: company[:linkedin]
      fill_in  'Rede Social 2', with: company[:facebook]
      fill_in  'Rede Social 3', with: company[:twitter]
      fill_in 'Logradouro', with: company[:company_address][:public_place]
      fill_in 'Bairro', with: company[:company_address][:district]
      fill_in 'Cidade', with: company[:company_address][:city]
      fill_in 'CEP', with: company[:company_address][:zip_code]
      click_on 'Criar Empresa'        
    end

    expect(current_path).to eq employees_company_path(Company.last)
    expect(page).to have_css('img[src*="campuscode.png"]')
    within('h1#name'){expect(page).to have_content 'Campus Code'}
    expect(page).to have_link 'Anuncie sua vaga', 
                              href: new_employees_company_job_path(Company.last)
    expect(page).to have_link 'Suas vagas anunciadas', 
                              href: employees_company_jobs_path(Company.last)
    within('h2#header'){expect(page).to have_content 'Informações'}
    within('div#info') do
      expect(page).to have_content 'CNPJ: 33.222.111/0050-46'
      expect(page).to have_link 'campuscode.com.br'
      expect(page).to have_content 'Redes Sociais'
      expect(page).to have_link 'http://www.linkedin.com/school/campus-code/'
      expect(page).to have_link 'http://www.facebook.com/CampusCodeBr/'
      expect(page).to have_link 'http://www.twitter.com/campuscodebr'
      expect(page).to have_content 'Endereço da Empresa'
      expect(page).to have_content 'Logradouro: Rua Cícero, 41'
      expect(page).to have_content 'Bairro: Anhembi'
      expect(page).to have_content 'Cidade: São Paulo'
      expect(page).to have_content 'CEP: 41002-241'
      expect(page).to have_content 'Vem crescendo bastante'
    end
    expect(page).to have_link 'Voltar', href: employees_root_path
  end
  
  scenario 'with empty gaps' do 
    employee =  Employee.create!(
      email: 'henrique@campuscode.com.br', password: '123456',
      cpf: '12.345.678/9'
    )  
    employee.admin!
    login_as employee, scope: :employee
    
    visit new_employees_company_path
    within('form') do
      fill_in 'Nome', with: ''
      fill_in 'CNPJ', with: ''
      fill_in 'Site', with: ''
      fill_in 'História da Empresa', with: ''
      fill_in  'Rede Social 1', with: ''
      fill_in  'Rede Social 2', with: ''
      fill_in  'Rede Social 3', with: ''
      fill_in 'Logradouro', with: ''
      fill_in 'Bairro', with: ''
      fill_in 'Cidade', with: ''
      fill_in 'CEP', with: ''
      click_on 'Criar Empresa'        
    end

    expect(page).to have_content(
      'Endereço da rede social não pode ficar em branco'
    )
    expect(page).to have_content('Logradouro não pode ficar em branco')
    expect(page).to have_content('Bairro não pode ficar em branco')
    expect(page).to have_content('Cidade não pode ficar em branco')
    expect(page).to have_content('CEP não pode ficar em branco')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('CNPJ não pode ficar em branco')
    expect(page).to have_content('Site não pode ficar em branco')
    expect(page).to have_content('História da Empresa não pode ficar em branco')
    expect(page).to have_content('Redes Sociais não é válido')
    expect(page).to have_content('Endereço da Empresa não é válido')
   
  end

  xscenario 'attributes must be uniqueness' do
  end
end