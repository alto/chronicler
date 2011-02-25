ActiveRecord::Schema.define(:version => 0) do
  create_table :users, :force => true do |t| 
    t.datetime  :created_at
    t.datetime  :logged_in_at
    t.string    :name
  end 
end
