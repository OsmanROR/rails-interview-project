class CreateTenants < ActiveRecord::Migration[7.0]
  def change
    create_table :tenants do |t|
      t.string  :name
      t.string  :api_key
      t.integer :api_request_count, default: 0

      t.timestamps
    end
  end
end
