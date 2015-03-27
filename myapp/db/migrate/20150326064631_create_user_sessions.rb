class CreateUserSessions < ActiveRecord::Migration
  def change
    create_table :'user_sessions.css' do |t|
      t.string :session_id, :null => false
      t.text :data
      t.timestamps
    end

    add_index :'user_sessions.css', :session_id
    add_index :'user_sessions.css', :updated_at

  end
end
