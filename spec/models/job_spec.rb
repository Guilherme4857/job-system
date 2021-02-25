require 'rails_helper'

RSpec.describe Job, type: :model do
  describe 'Job' do
    context '#job_attributes' do
      it 'successfully' do
        level = Level.create!(name: 'júnior')
        company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                                  site: 'campuscode.com', company_history: 'Vem crescendo bastante')
        job = Job.create!(company: company, title: 'Desenvolvedor Ruby', description: 'Vai desenvolver aplicações 
                          utilizando ruby', pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby', 
                          expiration_date: '23/04/2024', job_openings: 4, levels:[level])

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

    context '#disable!' do
      it 'successfully' do
        employee = Employee.create!(email: 'joao@campuscode.com', password: '123456')
        level = Level.create!(name: 'júnior')
        company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                                  site: 'campuscode.com', company_history: 'Vem crescendo bastante')
        job = Job.create!(company: company, title: 'Desenvolvedor Ruby', description: 'Vai desenvolver aplicações 
                          utilizando ruby', pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby', 
                          expiration_date: '23/04/2024', job_openings: 4, levels:[level])

        job.disable!
        job.reload
        
        expect(job.disabled?).to eq true
      end
    end 

    context '#enable!' do
      it 'successfully' do
        employee = Employee.create!(email: 'joao@campuscode.com', password: '123456')
        level = Level.create!(name: 'júnior')
        company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                                  site: 'campuscode.com', company_history: 'Vem crescendo bastante')
        job = Job.create!(company: company, title: 'Desenvolvedor Ruby', description: 'Vai desenvolver aplicações 
                          utilizando ruby', pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby', 
                          expiration_date: '23/04/2024', job_openings: 4, levels:[level])
        job.disable!
        
        job.enable!

        expect(job.disabled?).to eq false
      end
    end

    context '.all_enable' do
      it 'successfully' do
        employee = Employee.create!(email: 'joao@campuscode.com', password: '123456')
        company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                                  site: 'campuscode.com', company_history: 'Vem crescendo bastante')
        level = Level.create!(name: 'júnior')
        first_job = Job.create!(company: company, title: 'Desenvolvedor Ruby', description: 'Vai desenvolver aplicações 
                                utilizando ruby', pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby', 
                                expiration_date: '23/04/2024', job_openings: 4, levels:[level])
        second_job = Job.create!(company: company, title: 'Desenvolvedor Ruby', description: 'Vai desenvolver aplicações 
                                 utilizando ruby', pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby', 
                                 expiration_date: '23/04/2024', job_openings: 4, levels:[level])
        third_job = Job.create!(company: company, title: 'Desenvolvedor Ruby', description: 'Vai desenvolver aplicações 
                                utilizando ruby', pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby', 
                                expiration_date: '23/04/2020', job_openings: 4, levels:[level])
        fourth_job = Job.create!(company: company, title: 'Desenvolvedor Ruby', description: 'Vai desenvolver aplicações 
                                 utilizando ruby', pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby', 
                                 expiration_date: '23/04/2024', job_openings: 4, levels:[level])
        fourth_job.disable!
        enables = Job.all_enable.count
        
        expect(enables).to eq 2
      end
    end
  end
end
