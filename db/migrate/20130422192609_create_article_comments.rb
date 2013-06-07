class CreateArticleComments < ActiveRecord::Migration
  def change
    create_table :article_comments do |t|
      t.integer :article_id
      t.string :email
      t.text :comment
      t.boolean :active

      t.timestamps
    end
  end
end
