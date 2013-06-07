class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.integer :article_category_id
      t.string :author_name
      t.boolean :published
      t.string :image
      t.string :tags

      t.timestamps
    end
  end
end
