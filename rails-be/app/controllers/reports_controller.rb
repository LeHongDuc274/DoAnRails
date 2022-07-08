class ReportsController < ApplicationController

	def revenue_all_time_per_month
		start_time = Order.minimum("created_at")
		end_time = Order.maximum("created_at")

		revenue_per_month = []
		start_this_month = start_time.beginning_of_month
		end_this_month = start_time.end_of_month

		orders = Order.all

		begin
			# sum_this_month = Order.where("created_at BETWEEN ? AND ?", start_this_month, end_this_month)
			# 											.sum("total_price")

			sum_this_month = orders.select{ |e|
				e.created_at <= end_this_month && e.created_at >= start_this_month
			}.sum {|s| s.total_price}

			revenue_per_month << {
				time: start_this_month.strftime("%m-%Y"),
				revenue: sum_this_month
			}

			start_this_month += 1.month
			end_this_month = start_this_month.end_of_month

		end while (start_this_month <= end_time)

		render json: {
			status: true,
			data: revenue_per_month
		}

	end

	def revenue_last_week
		end_time = Time.now
		start_time = end_time.beginning_of_day - 6.days
		orders_this_week = Order.where("created_at BETWEEN ? AND ?", start_time, end_time)
		data = []
		
		7.times{ |day|
			total = orders_this_week.select{ |order|
				order.created_at >= start_time && order.created_at <= start_time.end_of_day
			}.sum{ |s| s.total_price}
			data << {
				time: start_time.strftime("%d-%m"),
				revenue: total 
			}
			start_time = start_time.next_day
		}
		render json: {
			status: true,
			data: data
		}
	end


	def product
		case params[:type].to_i

		when 0
			product_by_time (Time.now.beginning_of_day)
		when 1
			product_by_time (Time.now.beginning_of_day - 6.days)
		when 2
			product_by_time 0
		else 
			render json:{
				status: false,
				data: nil
			}, status: 404
		end
	end

	def product_by_time start_time
		end_time = Time.now
		# order_details_this_week = OrderDetail.where("created_at BETWEEN ? AND ?", start_time, end_time)
		data = []
		products = Product.all.eager_load(:order_details).where("order_details.created_at BETWEEN ? AND ?", start_time, end_time)
		# products_hash = order_details_this_week.group_by(&:product_id)
		products.each{ |product|
			order_details = product.order_details

			data << {
				product: product.id,
				category_id: product.category_id,
				product_name: product.name,
				count: product.order_details.pluck(:amount).sum(),
				revenue: product.order_details.pluck(:total_price).sum()
			}
		}

		render json: {
			status: true,
			data: data.sort_by { |dt| -dt[:count] }
		}
	end

	def report_today
		today = Time.now
		yesterday = today.beginning_of_day - 1.day
		orders = Order.where("orders.created_at BETWEEN ? AND ?", yesterday, today).eager_load(:order_details)
		revenue = orders.sum{|e| e.total_price}
		dish_order = orders.sum {|order|
			order.order_details.pluck(:amount).sum()
		}
		customer = orders.size

		revenue_today = 0
		dish_order_today = 0
		customer_today = 0

		orders.each{ |order| 
			if order.created_at >= today.beginning_of_day && order.created_at <= today
				revenue_today += order.total_price
				dish_order_today += order.order_details.pluck(:amount).sum()
				customer_today += 1
			end
		}

		revenue_change = revenue_today/(revenue - revenue_today).to_f - 1 if (revenue - revenue_today) != 0
		dish_order_change = dish_order_today/(dish_order - dish_order_today).to_f - 1 if (dish_order - dish_order_today) != 0
		customer_change = customer_today/(customer - customer_today).to_f - 1 if (customer - customer_today) != 0

		render json:{
			status: true,
			data: {
				total_revenue: revenue_today ,
				total_revenue_change: revenue_change,
				total_dish_order: dish_order_today,
				total_dish_order_change: dish_order_change,
				total_customer: customer_today,
				total_customer_change: customer_change
			}
		}
	end

end