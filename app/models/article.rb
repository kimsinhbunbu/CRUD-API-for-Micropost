class Article < ApplicationRecord
    validates  :article_title, presence: true
    validates  :article_content, presence: true
    belongs_to :category
end
