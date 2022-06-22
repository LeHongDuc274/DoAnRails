class CategoriesController < ApplicationController

	before_action :can_modify_user? ,except: [:index]

	def index
		categories = Category.all

		if categories
			render json: {
				status: true,
				data: categories
			}
		else
			render json: {
				status: false,
				data: categories.errors.full_messages
			}, status: 404
		end

	end

	def create
		category = Category.new(name_type: params[:name_type])

		if category.invalid?
			render json: {
				status: false,
				data: category.errors.full_messages
			}, status: 404
		else
			category.save
			render json: {
				status: true,
				data: category
			}
		end

	end

	def delete
		category = Category.find params[:id]
		if category && category.destroy
			render json: {
				status: true,
				data: category
			}
		else 
			render json: {
				status: false,
				data: category.errors.full_messages
			}, status: 404
		end
	end


	def edit
		edit_params = params.permit[:name_type]
		category = Category.find params[:id]

		edit_params.each do |k ,v|
		if !category.update(k => v)
			render json: {
				status: false,
				data: category.errors.full_messages
			}, status: 404
			return
		end

		end

		if category
		render json: {
			status: true,
			data: category
		}
		else
		render json: {
			status: false,
			data: {

			}
		}, status: :not_found
		end
	end

end
