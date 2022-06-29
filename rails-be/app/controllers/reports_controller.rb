class ReportsController < ApplicationController


	def revenue_all_time_per_month

		start_time = Order.minimum("created_at")
		end_time = Order.maximum("created_at")

		revenue_per_month = []
		start_this_month = start_time.beginning_of_month
		end_this_month = start_time.end_of_month

		begin
			sum_this_month = Order.where("created_at BETWEEN ? AND ?", start_this_month, end_this_month)
			.sum("total_price")

			revenue_per_month << {
				time: start_this_month,
				revenue: sum_this_month
			}
			start_this_month += 1.month
			end_this_month = start_this_month.end_of_month

		end while (start_this_month.to_time <= end_time)

		render json: {
			status: true,
			data: revenue_per_month
		}

	end


	def revenue_last_week

	end


end