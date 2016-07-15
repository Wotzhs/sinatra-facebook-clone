class CreateUsersStatusesLikesFriends < ActiveRecord::Migration
	def change
		create_table :users do |u|
			u.string :name, null: false
			u.string :email, null: false, uniqueness: true
			u.string :date_of_birth, null: false
			u.string :hashed_password, null: false
			u.timestamps null: false
		end

		create_table :statuses do |s|
			s.integer :user_id, null: false
			s.string :status, :limit => 140, null: false
			s.timestamps null: false
		end

		create_table :likes do |l|
			l.integer :user_id, null: false
			l.integer :status_id, null: false
			l.timestamps null: false
		end

		create_table :friends do |f|
			f.integer :user_id, null: false
			f.integer :friend_id, null: false
			f.timestamps null: false
		end

	end
end
