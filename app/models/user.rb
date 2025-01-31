require 'active_record'

class User < ActiveRecord::Base
  has_and_belongs_to_many :interests
  has_and_belongs_to_many :skills
end
