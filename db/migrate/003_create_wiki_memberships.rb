class CreateWikiMemberships < ActiveRecord::Migration
	def self.up
		create_table :wiki_memberships do |t|
			t.integer :user_id
			t.integer :wiki_id
			t.boolean :active, :default => false
			t.boolean :owner,  :default => false
			t.timestamps
		end
	end

	def self.down
		drop_table :wiki_memberships
	end
end
