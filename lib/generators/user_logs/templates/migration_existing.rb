class AddLogTo<%= table_name.camelize %> < ActiveRecord::Migration<%= migration_version %>
  def self.up
    change_table :<%= table_name %> do |t|
      t.inet       :ip
      t.integer    :user_id
      t.string     :user_type
      t.string     :method
      t.string     :url
      t.integer    :response
      t.string     :agent
      t.text       :params
      t.text       :response_body
      t.string     :country
      t.string     :browser_uuid
      t.datetime   :created_at
    end
  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    raise ActiveRecord::IrreversibleMigration
  end
end
