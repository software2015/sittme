class RemoveIndexFromBabysittersFirstName < ActiveRecord::Migration[6.0]

	def up
		remove_index :babysitters, :first_name
  end

  def down # откат
		add_index :babysitters, :first_name
  end

 end
