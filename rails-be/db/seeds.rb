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
# 5.times { |n|
#     category = Category.create!(name_type: "category #{n}")

#     10.times { |t|
#         product = Product.create!(name: "product #{t} cate #{n}", content: "content #{t}", 
#             price: (t+1)*10000, status: 0 ,category_id: category.id)
#         product.image.attach(io: File.open(File.join(Rails.root, 'app/assets/images/pho1.jpeg')),filename: 'pho1.jpeg')
#     }
# }

#Com
com = Category.create!(name_type: "Cơm")
product = Product.create!(name: "Cơm gà sốt me đặc biệt", content: "Cơm đùi gà rút xương chiên giòn chấm cùng nước sốt me siêu đặc biệt (hạt me ăn được), ăn kèm với rau xào theo mùa và trứng cuộn kiểu Nhật", 
  price: 43000, status: 0 ,category_id: com.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/com_ga_sot_me_dac_biet.jpeg')),filename: 'com_ga_sot_me_dac_biet.jpeg')

product = Product.create!(name: "Cơm gà sốt tiêu đen", content: "Cơm bò bắp xào sốt tiêu đen ăn kèm với trứng cuộn kiểu Nhật, rau xào theo mùa và canh", 
  price: 45000, status: 0 ,category_id: com.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/com_ga_sot_tieu_den.jpeg')),filename: 'con_ga_sot_tieu_den.jpeg')

product = Product.create!(name: "Cơm thịt rang cháy cạnh", content: "Cơm thịt ba chỉ rang cháy cạnh ăn kèm với rau xào theo mùa và trứng cuộn kiểu Nhật", 
  price: 51000, status: 0 ,category_id: com.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/com_thit_rang_chay_canh.jpeg')),filename: 'com_thit_rang_chay_canh.jpeg')

product = Product.create!(name: "Cơm gà sốt nấm", content: "Cơm đùi gà rút xương xào cùng các loại nấm sốt dầu hào ăn kèm với rau theo mùa và trứng cuộn kiểu Nhật", 
  price: 48000, status: 0 ,category_id: com.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/com_ga_sot_nam.jpeg')),filename: 'com_ga_sot_nam.jpeg')

product = Product.create!(name: "Cơm cá kho riềng sả", content: "01 khúc cá ba sa kho riềng sả ăn kèm với rau theo mùa và trứng cuộn kiểu Nhật", 
  price: 40000, status: 0 ,category_id: com.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/com_ca_kho_rieng_sa.jpg')),filename: 'com_ca_kho_rieng_sa.jpg')

product = Product.create!(name: "Cơm thịt chiên sốt Thái", content: "Cơm thịt chiên sốt thái ăn kèm với rau xào theo mùa và trứng cuộn kiểu Nhật", 
  price: 44000, status: 0 ,category_id: com.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/com_thit_chien_sot_thai.jpeg')),filename: 'com_thit_chien_sot_thai.jpeg')

product = Product.create!(name: "Cơm thịt ba chỉ xào cay Hàn Quốc", content: "Cơm Thịt ba chỉ xào sốt cay hàn quốc ăn kèm trứng cuộn kiểu nhật và rau theo mùa", 
  price: 50000, status: 0 ,category_id: com.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/com_thit_ba_chi_xao_cay_han_quoc.jpeg')),filename: 'com_thit_ba_chi_xao_cay_han_quoc.jpeg')




pho = Category.create!(name_type: "Mì/Phở")

product = Product.create!(name: "Mì trộn thập cẩm", content: "Bao gồm : 1 Mì + 1 mực xoắn + 1 bò viên + 1 tôm viên + 1 sủi cảo+ 1 hồ lô+1 tôm con+ 1 trứng cút + rau củ", 
  price: 40000, status: 0 ,category_id: pho.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/mi_tron_thap_cam.jpg')),filename: 'mi_tron_thap_cam.jpg')

product = Product.create!(name: "Mì trộn Xúc xích", content: "Bao gồm : 1 Mì +1 xúc xích nguyên cái + rau củ", 
  price: 30000, status: 0 ,category_id: pho.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/mi_tron_xuc_xich.jpg')),filename: '.jpg')

product = Product.create!(name: "Mì trộn sủi cảo", content: "Bao gồm : 1 Mì + 5 sủi cảo + rau củ", 
  price: 25000, status: 0 ,category_id: pho.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/mi_tron_sui_cao.jpeg')),filename: 'mi_tron_sui_cao.jpeg')

product = Product.create!(name: "Mì trộn trứng cút", content: "Bao gồm : 1 Mì + 5 trứng cút +rau củ ", 
  price: 35000, status: 0 ,category_id: pho.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/mi_tron_trung_cut.jpg')),filename: 'mi_tron_trung_cut.jpg')

product = Product.create!(name: "Mì trộn tôm", content: "Bao gồm : 1 Mì + 5 tôm con + rau củ", 
  price: 50000, status: 0 ,category_id: pho.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/mi_tron_tom.jpeg')),filename: 'mi_tron_tom.jpeg')

product = Product.create!(name: "Mì trộn mực xoắn", content: "Bao gồm : 1 Mì + 5 mực xoắn + rau củ", 
  price: 45000, status: 0 ,category_id: pho.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/mi_tron_muc_xoan.jpg')),filename: 'mi_tron_muc_xoan.jpg')

product = Product.create!(name: "Bún chả đặc biệt", content: "Bao gồm Chả Miếng, Chả Băm và Chả lá lốt...đóng gói theo tiêu chuẩn BAMBO VN.", 
  price: 50000, status: 0 ,category_id: pho.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/bun_cha_dac_biet.jpeg')),filename: 'bun_cha_dac_biet.jpeg')

product = Product.create!(name: "Bún cá măng cay", content: "Sự kết hợp giữa cá giòn, măng cay cùng với nước dùng độc đáo. Ăn là nghiền!", 
  price: 50000, status: 0 ,category_id: pho.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/bun_ca_mang_cay.jpeg')),filename: 'bun_ca_mang_cay.jpeg')

product = Product.create!(name: "Bún nem hải sản", content: "Bún ăn kèm với nem hải sản + rau sống", 
  price: 45000, status: 0 ,category_id: pho.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/bun_nem_hai_san.jpeg')),filename: 'bun_nem_hai_san.jpeg')

product = Product.create!(name: "Bún đậu mẹt", content: " Bún Đậu Đặc Biệt Siêu Topping Bao Gồm : Bún Nắm + Đậu + Chả Cốm + Nem Rán + Dồi Sụn + Thịt Chân Giò + Rau Sống , Dưa Chuột + Kẹo", 
  price: 55000, status: 0 ,category_id: pho.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/bun_dau_met.jpeg')),filename: 'bun_dau_met.jpeg')

product = Product.create!(name: "Phở bò chín", content: "bao gồm có bát, đũa, thìa, chanh, tương ớt", 
  price: 35000, status: 0 ,category_id: pho.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/pho_bo_chin.jpeg')),filename: 'pho_bo_chin.jpeg')

product = Product.create!(name: "Phở tái lăn", content: "Bao gồm thịt bò, hành tây, giá đỗ được lăn qua chảo", 
  price: 40000, status: 0 ,category_id: pho.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/pho1.jpeg')),filename: 'pho1.jpeg')


pizza = Category.create!(name_type: "Pizza/Burger")

product = Product.create!(name: "Bánh mì thịt nướng tiêu", content: "Thịt nướng nóng hổi kèm sốt tiêu thơm và salad .", 
  price: 35000, status: 0 ,category_id: pizza.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/banh_mi_thit_nuong_tieu.jpg')),filename: 'banh_mi_thit_nuong_tieu.jpg')

product = Product.create!(name: "Hamburger bò", content: "Hamburger bò với sốt đen và rau củ muối .", 
  price: 45000, status: 0 ,category_id: pizza.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/hamburger_bo.jpg')),filename: 'hamburger_bo.jpg')

product = Product.create!(name: "Bánh mì thịt nướng HongKong", content: "Thịt heo tẩm ướp nướng phong cách HongKong . Kèm sốt đặc biệt kiểu Umbala hòa quyện tạo lên 1 vị đặc trưng ngon tuyệt vời ", 
  price: 50000, status: 0 ,category_id: pizza.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/banh_mi_thit_nuong_hongkong.jpeg')),filename: 'banh_mi_thit_nuong_hongkong.jpeg')

product = Product.create!(name: "Bánh mì thịt nướng phomai", content: "Thịt nướng thơm phức, với sốt umbala chef BBQ riêng biệt với pho mai vàng . Tạo lên vị đượm kiểu BBQ mà không ở đâu có được ", 
  price: 40000, status: 0 ,category_id: pizza.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/banh_mi_thit_nuong_cheese.jpg')),filename: 'banh_mi_thit_nuong_cheese.jpg')

product = Product.create!(name: "Hamburger Tôm", content: "Tôm Việt Nam kết hợp với nguyên liệu của Ý tạo lên 1 vị riêng biệt của Umbala .", 
  price: 40000, status: 0 ,category_id: pizza.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/hamburger_tom.jpg')),filename: 'hamburger_tom.jpg')



trangmieng = Category.create!(name_type: "Tráng miệng")

product = Product.create!(name: "Bông lan trứng muối", content: "Phần bông lan mềm, thơm ngon và ít ngọt. Loại đặc biệt sẽ có phô mai và thêm nhiều sốt trứng", 
  price: 48000, status: 0 ,category_id: trangmieng.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/bong_lan_trung_muoi.jpeg')),filename: 'bong_lan_trung_muoi.jpeg')


product = Product.create!(name: "Bánh Sukem", content: "Bánh Sukem vỏ ngoài mềm bên trong có nhân sữa ngọt thanh", 
  price: 14000, status: 0 ,category_id: trangmieng.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/banh_su_kem.jpeg')),filename: 'banh_su_kem.jpeg')


product = Product.create!(name: "Bánh mè đen socola", content: "Bánh mì mochi mè đen vị socola bé bé xinh xinh, có vỏ giòn bên ngoài và nhân bánh dẻo mềm, hơi rỗng ruột. Bánh này xuất xứ từ Hàn Quốc. Bánh rất thích hợp như loại snack để ăn cùng bạn bè và gia đình.", 
  price: 40000, status: 0 ,category_id: trangmieng.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/banh_me_den_socola.jpeg')),filename: 'banh_me_den_socola.jpeg')


product = Product.create!(name: "Bánh mè đen vani", content: "Bánh mì mochi mè đen vị vani bé bé xinh xinh, có vỏ giòn bên ngoài và nhân bánh dẻo mềm, hơi rỗng ruột. Bánh này xuất xứ từ Hàn Quốc. Bánh rất thích hợp như loại snack để ăn cùng bạn bè và gia đình.", 
  price: 45000, status: 0 ,category_id: trangmieng.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/banh_me_den_vani.jpeg')),filename: 'banh_me_den_vani.jpeg')


product = Product.create!(name: "Bánh bông lan kem dừa nướng", content: "Bánh bông lan kem dừa nướng với sốt kem trứng béo ngậy, có vị mặn ngọt ngọt hoà quyện, không hề tanh mùi trứng kết hợp cùng với vụn dừa nướng giòn rụm tạp nên hương vị thơm ngon khó cưỡng", 
  price: 34000, status: 0 ,category_id: trangmieng.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/banh_bong_lan_kem_dua.jpeg')),filename: 'banh_bong_lan_kem_dua.jpeg')


product = Product.create!(name: "Caramen", content: "Caramen của Tiệm được khách hàng rất yêu thích. Bánh làm mới hàng ngày vị vừa và rất ngon miệng", 
  price: 10000, status: 0 ,category_id: trangmieng.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/caramen.jpeg')),filename: 'caramen.jpeg')



product = Product.create!(name: "Bông lan Hoa cúc", content: "Thương vì bánh mềm, thơm ngon và luôn tươi mới. ", 
  price: 30000, status: 0 ,category_id: trangmieng.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/bong_lan_hoa_cuc.jpeg')),filename: 'bong_lan_hoa_cuc.jpeg')



douong = Category.create!(name_type: "Đồ uống")

product = Product.create!(name: "Trà sữa trân châu đường đen", content: "Brown Sugar Fresh Milk Bubble", 
  price: 90000, status: 0 ,category_id: douong.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/tra_sua_tran_chau_duong_den.jpg')),filename: 'tra_sua_tran_chau_duong_den.jpg')

product = Product.create!(name: "Trà sữa sương sáo", content: "Grass Jelly Milk Tea", 
  price: 80000, status: 0 ,category_id: douong.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/suong_sao.jpg')),filename: 'suong_sao.jpg')


product = Product.create!(name: "Trà sữa Konjac", content: "Konjac Jelly Milk Tea", 
  price: 100000, status: 0 ,category_id: douong.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/konjac.jpg')),filename: 'konjac.jpg')


product = Product.create!(name: "Thạch dừa trân châu", content: "Coconut Jelly Bubble Green Milk Tea", 
  price: 40000, status: 0 ,category_id: douong.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/thach_dua_tran_chau.jpeg')),filename: 'thach_dua_tran_chau.jpeg')


product = Product.create!(name: "Sữa tươi trân châu", content: "Brown Sugar Fresh Milk Bubble", 
  price: 40000, status: 0 ,category_id: douong.id)
product.image.attach(io: File.open(File.join(Rails.root, 
  'app/assets/images/sua_tuoi_tran_chau.jpeg')),filename: 'sua_tuoi_tran_chau.jpeg')


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


  tables = User.where("role = 3")
  products = Product.all
  start_time = 1.year.ago.to_i
  end_time = Time.now.to_i
  tables.each{ |table|
    rand(200..500).times { |n1|
      time = Random.rand(start_time..end_time)
      order = Order.new(
        user_id: table.id,
        status: 1,
        total_price: 0
        )
      order.created_at = Time.at(time)
      order.save
      total_price = 0
      rand(1..10).times { |n2|
        product = products.shuffle().first
        amount = rand(1..10)
        total_price_detail = product.price* amount
        order_details_new = OrderDetail.new( user_id: table.id,product_id: product.id,
          order_id: order.id, amount: amount, total_price: total_price_detail,note: "", status: 4 )
        order_details_new.created_at = Time.at(time)
        order_details_new.save
        total_price += total_price_detail
      }
      order.update(total_price: total_price)
    }
  }


  # 10.times do |n|
  #   Product.create!(name: "product no cate #{n}", content: "content #{n}",
  #       price: (n+1)*10000, status: 0 , image: "image", category_id: nil)

  # end
