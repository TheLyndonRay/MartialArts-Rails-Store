class AddPicturesToProducts < ActiveRecord::Migration
  def change
    add_column :products, :pictures, :string
  end
end
