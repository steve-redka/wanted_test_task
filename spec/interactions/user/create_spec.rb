require 'rails_helper'
require './app/interactions/user/create'
require 'active_record'

RSpec.describe User::Create do
  let(:inputs) { {} }
  let(:outcome) { described_class.run(inputs) }
  let(:outcome!) { described_class.run!(inputs) }
  let(:result) { outcome.result }
  let(:errors) { outcome.errors }

  let!(:default_params) do
    { name: 'John',
      patronymic: 'Doe',
      email: 'admin@admin.com',
      age: 25,
      nationality: 'American',
      country: 'USA',
      gender: 'male',
      interests: %w[coding reading],
      skills: %w[ruby rails] }
  end

  it 'does nothing if params are empty' do
    expect(outcome).to be_invalid
    expect { outcome }.not_to(change { User.count })
  end

  it 'creates a user if params are valid' do
    inputs[:params] = default_params
    expect { outcome! }.to(change { User.count })
  end

  context 'email' do
    it 'is invalid if email is not unique' do
      User::Create.run!(params: default_params)
      User::Create.run(params: default_params)
      expect(outcome).to be_invalid
    end

    it 'is valid if email is unique' do
      User::Create.run!(params: default_params)
      inputs[:params] = default_params.merge(email: 'baz@baz.com')
      expect(outcome).to be_valid
    end
  end

  context 'age' do
    it 'is invalid if age is less than 0' do
      inputs[:params] = default_params.merge(age: -1)
      expect(outcome).to be_invalid
    end

    it 'is invalid if age is greater than 90' do
      inputs[:params] = default_params.merge(age: 91)
      expect(outcome).to be_invalid
    end
  end

  context 'gender' do
    it 'is invalid if it is empty' do
      inputs[:params] = default_params.merge(gender: 'f')
      expect(outcome).to be_invalid
    end
  end
end
