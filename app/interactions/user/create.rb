require './app/models/user'
require 'active_interaction'

class User::Create < ActiveInteraction::Base
  hash :params do
    string :name
    string :patronymic
    string :email
    integer :age
    string :nationality
    string :country
    string :gender, inclusion: { in: %w[male female] }
    array :interests, default: []
    array :skills, default: []
  end

  validate :validate_age
  validate :validate_gender
  validate :validate_unique_email

  def execute
    user = User.create!(params.except(:interests, :skills))

    user.interests = Interest.where(name: params[:interests])
    user.skills = Skill.where(name: params[:skills])

    user.save!
    user
  end

  private

  def validate_age
    return unless params[:age].present?

    errors.add(:params, 'age must be between 1 and 90') unless (1..90).include?(params[:age])
  end

  def validate_gender
    return unless params[:gender].present?

    errors.add(:params, "gender must be 'male' or 'female'") unless %w[male female].include?(params[:gender])
  end

  def validate_unique_email
    errors.add(params[:email], :not_unique) if User.exists?(email: params[:email])
  end
end
