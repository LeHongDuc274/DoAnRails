class ReportsController < ApplicationController

	def revenue_all_time_per_month
		if @current_user.is_admin? 
			render json: {
				status: true,
				data: Admin::ReportAdminLogic.new.call_revenue_all_time_per_month 
			}
		else
			render json:{
				status: false,
				message: "không phải admin"
			}
		end
	end

	def revenue_last_week
		end_time = Time.now
		start_time = end_time.beginning_of_day - 6.days
		if @current_user.is_admin? 
			render json: {
				status: true,
				data: Admin::ReportAdminLogic.new.call_revenue_last_week(start_time, end_time) 
			}
		else
			render json:{
				status: false,
				message: "không phải admin"
			}
		end
	end

	def report_period_time
		start_time = params[:start].to_s.to_time
		end_time = params[:end].to_s.to_time.end_of_day
	if @current_user.is_admin? 
			render json: {
				status: true,
				data: Admin::ReportAdminLogic.new.call_report_period_time(start_time, end_time) 
			}
		else
			render json:{
				status: false,
				message: "không phải admin"
			}
		end
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
				message: "Lựa chọn không tồn tại"
			}
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
	if @current_user.is_admin? 
			render json: {
				status: true,
				data: Admin::ReportAdminLogic.new.call_report_today
			}
		else
			render json:{
				status: false,
				message: "không phải admin"
			}
		end
	end

end