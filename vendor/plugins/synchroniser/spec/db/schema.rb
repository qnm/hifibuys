ActiveRecord::Schema.define(:version => 0) do
  create_table :sync_items, :force => true  do |t|
    t.string :item
    t.string :group
    t.string :class_name
    t.string :class_id
    t.string :status

    t.timestamps
  end
end
