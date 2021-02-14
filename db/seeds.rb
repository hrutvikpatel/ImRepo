User.create!(email: "test@user.com",password: "12345678")

Account.create!([
  {user_id: 1, balance: "883.0"},
  {user_id: 1, balance: "0.0"},
  {user_id: 1, balance: "0.0"},
  {user_id: 1, balance: "0.0"}
])
Category.create!([
  {name: "Doggo"},
  {name: "Cats"},
  {name: "Nature"},
  {name: "Dog   Herding Group"},
  {name: "Anime"}
])

products = Product.create!([
  {
    title: "Austrailian Shepherd",
    description: "I always wanted one <3",
    price: "10.0"
  },
  {
    title: "Australian Cattle Dog",
    description: "A Cattle Dog",
    price: "10.0"
  },
  {
    title: "Playful puppy",
    description: "Puppy playing with a ball",
    price: "100.0"
  },
  {
    title: "Cat on an adventure",
    description: "Cat discovers flowers :)",
    price: "10.0"
  },
  {
    title: "France Mountains",
    description: "Beautiful mountains in France!",
    price: "10.0"
  },
  {
    title: "Lavender Field",
    description: "Lavender Fields in the United Kingdom.",
    price: "10.0"
  }
])

products[0].image.attach(io: File.open('app/assets/dummy/Herding-Australian-Shepherd.jpg'), filename: 'Herding-Australian-Shepherd.jpg')
products[1].image.attach(io: File.open('app/assets/dummy/Herding-Australian-Cattle-Dog.jpg'), filename: 'Herding-Australian-Cattle-Dog.jpg')
products[2].image.attach(io: File.open('app/assets/dummy/puppy-ball.jpeg'), filename: 'puppy-ball.jpeg')
products[3].image.attach(io: File.open('app/assets/dummy/cat.jpeg'), filename: 'cat.jpeg')
products[4].image.attach(io: File.open('app/assets/dummy/france mountains.jpeg'), filename: 'france mountains.jpeg')
products[5].image.attach(io: File.open('app/assets/dummy/lavendar field.jpeg'), filename: 'lavendar field.jpeg')


ProductCategory.create!([
  {product_id: 1, category_id: 1},
  {product_id: 1, category_id: 4},
  {product_id: 2, category_id: 1},
  {product_id: 2, category_id: 4},
  {product_id: 3, category_id: 1},
  {product_id: 4, category_id: 2},
  {product_id: 5, category_id: 3},
  {product_id: 6, category_id: 3}
])

Order.create!([
  {user_id: 1, account_id: 1, product_id: 1, cost: "10.0"},
  {user_id: 1, account_id: 1, product_id: 2, cost: "10.0"},
  {user_id: 1, account_id: 1, product_id: 3, cost: "100.0"}
])

Admin.create!(email: 'admin@imrepo.com', password: '12345678')
