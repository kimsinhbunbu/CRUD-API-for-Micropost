# frozen_string_literal: true

3.times do
  Category.create({
                    category_name: Faker::Book.title
                  })
end
