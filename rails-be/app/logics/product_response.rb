class ProductResponse
attr_accessor :name , :id, :content ,:price ,:status ,:image_url
def initialize(id, name_product, content, price, status, category_id, image_url)
	@id = id
	@name = name_product
	@content = content
	@price = price.to_i
	@status = status.to_i
	@category_id = category_id.to_i
	@image_url = image_url
end
end