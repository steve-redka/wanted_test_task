class CreateUsersInterestsSkills < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.string :patronymic
      t.string :email, null: false, index: { unique: true }
      t.integer :age
      t.string :nationality
      t.string :country
      t.string :gender

      t.timestamps
    end

    create_table :interests do |t|
      t.string :name, null: false

      t.timestamps
    end

    create_table :skills do |t|
      t.string :name, null: false

      t.timestamps
    end

    create_table :interests_users, id: false do |t|
      t.belongs_to :user
      t.belongs_to :interest
    end

    create_table :skills_users, id: false do |t|
      t.belongs_to :user
      t.belongs_to :skill
    end
  end
end
