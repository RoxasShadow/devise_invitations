class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :sent_by_id, null: false
      t.string  :email,      null: false
      t.integer :status,     null: false, default: 0
      t.string  :token,      null: false

      t.timestamps null: false
    end

    add_index :invitations, :sent_by_id
    add_index :invitations, :email
    add_index :invitations, :status
    add_index :invitations, :token

    add_foreign_key :invitations, :users, column: :sent_by_id
  end
end
