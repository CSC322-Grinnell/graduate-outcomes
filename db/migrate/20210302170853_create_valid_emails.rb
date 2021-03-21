class CreateValidEmails < ActiveRecord::Migration[6.0]
  def change
    create_table :valid_emails do |t|
      t.string :email

      t.timestamps
    end
  end
end
