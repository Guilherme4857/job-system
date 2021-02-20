require 'rails_helper'

RSpec.describe CompanyAddress, type: :model do
  describe 'Company Address' do
    context '#company_address_attributes' do
      it 'get attributes' do
        company = Company.create!(name: 'Google', cnpj: '44.555.666/0200-20', 
                                  site: 'google.com', company_history: 'Cresceu bastante')    
        company_address = CompanyAddress.create!(company: company, public_place: 'Rua Cícero, 41', 
                                                 district: 'Anhembi', city: 'São Paulo', 
                                                 zip_code: '41002-241')

        public_place = company_address.company_address_attributes(0)
        district = company_address.company_address_attributes(1)
        city = company_address.company_address_attributes(2)
        zip_code = company_address.company_address_attributes(3)

        expect(public_place).to eq 'Logradouro'
        expect(district).to eq 'Bairro'
        expect(city).to eq 'Cidade'
        expect(zip_code).to eq 'CEP'
        
      end      
    end
  end
end
