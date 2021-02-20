require 'rails_helper'

RSpec.describe Job, type: :model do
  describe 'Job' do
    context '#job_attributes' do
      it 'successfully' do
        company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                                  site: 'campuscode.com', company_history: 'Vem crescendo bastante')
        job = Job.create!(company: company, title: 'Desenvolvedor Ruby', description: 'Vai desenvolver aplicações 
                          utilizando ruby', pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby', 
                          expiration_date: '23/04/2024', job_openings: 4)

        title = job.job_attributes(0)
        description = job.job_attributes(1)
        pay_scale = job.job_attributes(2)
        requirements = job.job_attributes(3)
        expiration_date = job.job_attributes(4)
        job_openings = job.job_attributes(5)

        expect(title).to eq 'Título'
        expect(description).to eq 'Descrição Detalhada'
        expect(pay_scale).to eq 'Faixa Salarial'
        expect(requirements).to eq 'Requisitos Obrigatórios'
        expect(expiration_date).to eq 'Data Limite'
        expect(job_openings).to eq 'Total de Vagas'
      end
    end
  end
end
