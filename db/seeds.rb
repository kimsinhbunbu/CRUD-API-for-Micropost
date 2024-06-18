3.times do 
    Category.create({
        category_name: Faker::Book.title,
    })
end