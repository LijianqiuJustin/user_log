class Create<%= table_name.camelize %> < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :<%= table_name %> do |t|
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

    add_index :<%= table_name %>, [:user_id, :user_type]
    add_index :<%= table_name %>, :browser_uuid
  end
end