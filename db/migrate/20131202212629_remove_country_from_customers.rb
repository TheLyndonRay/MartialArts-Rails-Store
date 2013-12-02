class RemoveCountryFromCustomers < ActiveRecord::Migration
  def up

    remove_column :customers, :country

  end

  def down
  end
end
