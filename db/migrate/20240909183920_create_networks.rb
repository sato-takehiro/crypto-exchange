class CreateNetworks < ActiveRecord::Migration[7.2]
  def change
    create_table :networks do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
