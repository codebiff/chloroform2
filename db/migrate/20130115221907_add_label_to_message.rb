class AddLabelToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :label, :hstore
  end
end
