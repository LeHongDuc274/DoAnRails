# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(login_id: "Admin", display_name: "Admin", password: "123",
 password_confirmation: "123",role: 0 , status: 0, access_token: "", login_token: "")

#cate + product
5.times { |n|
    category = Category.create!(name_type: "category #{n}")

    10.times { |t|
        product = Product.create!(name: "product #{t} cate #{n}", content: "content #{t}", 
            price: (t+1)*10000, status: 0 ,category_id: category.id)
        product.image.attach(io: File.open(File.join(Rails.root, 'app/assets/images/pho1.jpeg')),filename: 'pho1.jpeg')
    }
}


10.times { |n|
    #create tale
    user = User.create!(login_id: "table#{n}", display_name: "table#{n}", password: "123",
 password_confirmation: "123",role: 3 , status: 0, access_token: "", login_token: "")

    #create order of table
    # order_done = Order.create!(user_id: user.id,status: 1,total_price: 0)

    # #create ordring 
    # ordering = Order.create!(user_id: user.id,status: 0 ,total_price: 0)
    #create order_details

    # 5.times {|t|
    #     OrderDetail.create!( user_id: user.id, product_id: t+1 ,
    #     order_id: order_done.id ,amount: 4, note: " this note  done", status: 1)

    #     OrderDetail.create!( user_id: user.id, product_id: t+1 ,
    #     order_id: ordering.id ,amount: 10, note: " this note ordering", status: 0)
    # }
  }


  10.times { |n|
User.create!(login_id: "staff#{n}", display_name: "staff#{n}", password: "123",
 password_confirmation: "123",role: 1 , status: 0, access_token: "", login_token: "")
  }

  10.times { |n|
User.create!(login_id: "kitchen#{n}", display_name: "kitchen#{n}", password: "123",
 password_confirmation: "123",role: 2 , status: 0, access_token: "", login_token: "")
  }


  # 10.times do |n|
  #   Product.create!(name: "product no cate #{n}", content: "content #{n}",
  #       price: (n+1)*10000, status: 0 , image: "image", category_id: nil)

  # end
