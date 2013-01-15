class AddConfirmUrlToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :confirm_url, :string
  end
end
