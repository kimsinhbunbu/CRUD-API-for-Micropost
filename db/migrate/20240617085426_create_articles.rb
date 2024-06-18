class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :article_title
      t.text :article_content

      t.timestamps
    end
  end
end
