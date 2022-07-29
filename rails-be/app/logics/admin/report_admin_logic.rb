class Admin::ReportAdminLogic

	def call_revenue_all_time_per_month

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
		revenue_per_month
	end

	def call_revenue_last_week start_time end_time
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
		data
	end

	def call_report_period_time start_time end_time
				orders = Order.where("created_at BETWEEN ? AND ?", start_time, end_time)
		data = []

		end_this_day = start_time.end_of_day

		begin
			sum_this_day = orders.select{ |e|
				e.created_at <= end_this_day && e.created_at >= start_time
			}.sum {|s| s.total_price}

			data << {
				time: start_time.strftime("%d-%m-%Y"),
				revenue: sum_this_day
			}

			start_time += 1.day
			end_this_day = start_time.end_of_day
		end while (start_time <= end_time)
		data
	end

	def call_report_today
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

			data = {
				total_revenue: revenue_today ,
				total_revenue_change: revenue_change,
				total_dish_order: dish_order_today,
				total_dish_order_change: dish_order_change,
				total_customer: customer_today,
				total_customer_change: customer_change
			}
	end

end