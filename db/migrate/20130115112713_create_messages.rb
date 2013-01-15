class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :user_id
      t.hstore :data

      t.timestamps
    end
    add_index :messages, :user_id_id
  end
end
