class ProductsController < ApplicationController
  def index
    q =params[:q] ||  ""
    from = params[:page] ||  0
    limit = params[:limit] || 20
    result = Product.search(q: q, pagination: { from: from, size: limit})
    @products= Kaminari.paginate_array(result.collection, total_count: result.total).page(from).limit(limit)
  end
end
