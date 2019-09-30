namespace :marketplace do
  desc "TODO"
  task :import_products, [:to] => :environment do |task, args|
    Store.all.destroy_all
    Product.all.destroy_all

    data = [
      {name: "Timex", website: "http://www.timex.com.br"},
      {name: "Fossil", website: "http://www.fossil.com.br"},
      {name: "Schumann", website: "https://www.schumann.com.br"}
    ]

    stores = Store.create(data)

    stores.each do |store|
      User.create(name: store.name, email: "admin@#{store.name.downcase}.com.br", password: '123456', profile: 'admin', store_id: store.id)
      3.times.each do |from|
        url = "#{store.website}/api/catalog_system/pub/products/search?_from=#{from}&_to=49"
        begin
          result = JSON(RestClient.get(url))
          result.map do |res|
            sellers = res["items"][0]["sellers"][0]
            commertial_offer = sellers["commertialOffer"]
            installments_res = commertial_offer["Installments"]
            product = Product.new(name: res["productName"],
                                  price: commertial_offer["Price"],
                                  store_id: store.id,
                                  installments: 3,
                                  url: res["link"],
                                  image: res["items"][0]["images"][0]["imageUrl"])
            product.save

          end

        rescue RestClient::ExceptionWithResponse => e
          e.response
        end
      end
    end
    MarketplaceIndex::import
  end
  desc "PUT in index"
end
