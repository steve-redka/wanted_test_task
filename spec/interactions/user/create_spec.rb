require 'rails_helper'
require './app/interactions/user/create'
require 'active_record'

RSpec.describe User::Create do
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
    expect(User::Create.run(params: {})).to be_invalid
  end

  it 'creates a user if params are valid' do
    expect { User::Create.run!(params: default_params) }.to(change { User.count })
  end

  context 'email' do
    it 'is invalid if email is not unique' do
      User::Create.run!(params: default_params)
      with_same_email = User::Create.run(params: default_params)
      expect(with_same_email).to be_invalid
    end

    it 'is valid if email is unique' do
      User::Create.run!(params: default_params)
      with_different_email = User::Create.run(params: default_params.merge(email: 'foo@baz.com'))
      expect(with_different_email).to be_valid
    end
  end

  context 'age' do
    it 'is invalid if age is less than 0' do
      params = default_params.merge(age: -1)
      expect( User::Create.run(params: params)).to be_invalid
    end

    it 'is invalid if age is greater than 90' do
        params = default_params.merge(age: 91)
        expect( User::Create.run(params: params)).to be_invalid
    end
  end

  context 'gender' do
    it 'is invalid if it is outside specified possibilities' do
      params = default_params.merge(gender: 'unicorn')
      expect( User::Create.run(params: params)).to be_invalid
    end
  end

  context 'interests' do
    it 'creates interests if they do not exist' do
      User::Create.run!(params: default_params)
      expect(Interest.count).to eq(2)
    end
  end

  context 'skills' do
    it 'creates skills if they do not exist' do
      User::Create.run!(params: default_params)
      expect(Skill.count).to eq(2)
    end
  end
end
