require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'Company' do
    context '#company_attributes' do
      it 'get attributes' do
        company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                                  site: 'campuscode.com.br', company_history: 'Vem crescendo bastante')    

        name = company.company_attributes(0)
        cnpj = company.company_attributes(2)
        site = company.company_attributes(3)
        company_history = company.company_attributes(4)

        expect(name).to eq 'Nome'
        expect(cnpj).to eq 'CNPJ'
        expect(site).to eq 'Site'
        expect(company_history).to eq 'História da Empresa'
      end
    end
  end
end
