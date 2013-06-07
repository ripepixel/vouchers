class AddNameToArticleComments < ActiveRecord::Migration
  def change
    add_column :article_comments, :name, :string
  end
end
