require 'rails_helper'

RSpec.describe Job, type: :model do
  describe 'Job' do
    context '#job_attributes' do
      it 'correct attribute' do
        job = Job.create!(title: 'Desenvolvedor Ruby',
                          description: 'Vai desenvolver aplicações utilizando ruby',
                          pay_scale: 'R$2000 - R$2600' ,level: 'Junior',
                          requirements: 'Saber ruby',expiration_date: '23/04/2024',job_openings: 4)

        title = job.job_attributes(0)
        description = job.job_attributes(1)
        pay_scale = job.job_attributes(2)
        level = job.job_attributes(3)
        requirements = job.job_attributes(4)
        expiration_date = job.job_attributes(5)
        job_openings = job.job_attributes(6)

        expect(title).to eq 'Título'
        expect(description).to eq 'Descrição Detalhada'
        expect(pay_scale).to eq 'Faixa Salarial'
        expect(level).to eq 'Nível'
        expect(requirements).to eq 'Requisitos Obrigatórios'
        expect(expiration_date).to eq 'Data Limite'
        expect(job_openings).to eq 'Total de Vagas'
      end

      it 'without arguments' do
        job = Job.create!(title: 'Desenvolvedor Ruby',
                          description: 'Vai desenvolver aplicações utilizando ruby',
                          pay_scale: 'R$2000 - R$2600' ,level: 'Junior',
                          requirements: 'Saber ruby',expiration_date: '23/04/2024',job_openings: 4)

        attribute = job.job_attributes

        expect(attribute).to eq nil        
      end

      it 'and argument out of range' do
        job = Job.create!(title: 'Desenvolvedor Ruby',
                          description: 'Vai desenvolver aplicações utilizando ruby',
                          pay_scale: 'R$2000 - R$2600' ,level: 'Junior',
                          requirements: 'Saber ruby',expiration_date: '23/04/2024',job_openings: 4)

        attribute = job.job_attributes 9
        other_attribute = job.job_attributes -1

        expect(attribute).to eq nil        
        expect(other_attribute).to eq nil           
      end

      it 'and argument not number' do
        job = Job.create!(title: 'Desenvolvedor Ruby',
                          description: 'Vai desenvolver aplicações utilizando ruby',
                          pay_scale: 'R$2000 - R$2600' ,level: 'Junior',
                          requirements: 'Saber ruby',expiration_date: '23/04/2024',job_openings: 4)

        first_attribute = job.job_attributes 'hellow'
        second_attribute = job.job_attributes [9, 3, 4]
        third_attribute = job.job_attributes 9.5

        expect(first_attribute).to eq nil        
        expect(second_attribute).to eq nil           
        expect(third_attribute).to eq nil           
      end

    end
  end
end
