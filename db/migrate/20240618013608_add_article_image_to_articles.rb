class AddArticleImageToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :article_image, :string
  end
end
