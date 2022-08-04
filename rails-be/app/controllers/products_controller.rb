class ProductsController < ApplicationController

before_action :can_modify_user? ,except: [:index,:change_status]

  def index
    products = Product.all.order("created_at DESC")

    if products
      # res = products.map { |e|
      #  ProductResponse.new(e.id , e.name, e.content , e.price ,e.status, e.category_id, url_for(e.image).to_s)
      # }
      res = []
      products.with_attached_image.each do |product|
        res << {
          id: product.id,
          name: product.name,
          content: product.content,
          price: product.price,
          status: product.status,
          category_id: product.category_id,
          image_url: url_for(product.image).to_s
        }
      end
      render json: {
        status: true,
        data: res
      }
    else
      render json: {
        status: false,
        data: nil,
        message: products.errors.full_messages
      }
    end

  end

  def create
    product = Product.new(name: params[:name], content: params[:content], price: params[:price].to_i,
      status: params[:status].to_i, category_id: params[:category_id].to_i
     )

    product.image.attach(params[:image])
    if product.invalid?
      render json: {
        status: false,
        data: nil ,
        message: product.errors.full_messages
      }
    else
      product.save
      product_res = ProductResponse.new(product.id , product.name, product.content ,
       product.price ,product.status, product.category_id,
        url_for(product.image).to_s )

      render json: {
        status: true,
        data: product_res
      }
    end

  end

  def delete
    product = Product.find params[:id]
    if product && product.destroy
      render json: {
        status: true,
        data: product
      }
    else 
      render json: {
        status: false,
        data: nil ,
        message: product.errors.full_messages
      }
    end
  end


  def edit
    edit_params = {
      name: params[:name], content: params[:content],status: params[:status].to_i,
      price: params[:price].to_i, category_id: params[:category_id].to_i,
    }
  
    product = Product.find params[:id].to_i

    product.image.attach(params[:image]) if params[:image].present?

    if !product.update(edit_params)
      render json: {
        status: false,
        data: nil ,
        message: product.errors.full_messages
      }
      return
    end

    if product
      product_res = ProductResponse.new(product.id , product.name, product.content ,
      product.price ,product.status, product.category_id,
      url_for(product.image).to_s )
    render json: {
      status: true,
      data: product_res
    }
    else
    render json: {
      status: false,
      data: nil ,
      message: "Có lỗi xảy ra"
    }
    end
  end

  def change_status
    product = Product.find params[:id].to_i
    new_status = 0
    new_status = 1 if product.status == 0

    if !product.update(status: new_status)
        render json: {
          status: true,
          data: true 
        }
    else 
      render json: {
        status: false,
        data: false,
        message: "Không thể chuyển trạng thái"
      }
    end
  end

  def income_by_time
    product = Product.find params[:id]
    start_time = params[:start]
    end_time = params[:end]
    if product 
      items = product.order_details.where("created_at >= ? AND create_at <= ?" ,
        start_time,end_time)
      count = items.sum{ |e| e.amount}
      income = count * (product.price)

      render json: {
        status: true,
        data: {
          product_id: params[:id],
          start_time: params[:start_time],
          end_time: params[:end_time],
          count: count,
          income: income
        }
      }
    else
      render json: {
        status: false,
        data: nil,
        message: product.errors.full_messages
      }
    end
  end

end