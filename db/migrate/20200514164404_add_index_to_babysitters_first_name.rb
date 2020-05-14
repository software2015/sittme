class AddIndexToBabysittersFirstName < ActiveRecord::Migration[6.0]
  def change # добавил просто для демонстрации отката
		add_index :babysitters, :first_name
  end
end
