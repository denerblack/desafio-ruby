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
      url = "#{store.website}/api/catalog_system/pub/products/search"
      url = "#{url}?_from=0&_to=#{args[:to]}" if args[:to].present?
      begin
        result = JSON(RestClient.get(url))
        result.map do |res|
          commertial_offer = res["items"][0]["sellers"][0]["commertialOffer"]
          installments_res = commertial_offer["Installments"]
          installments = installments_res.map do |installment|
            Installment.new(value: installment["Value"], number_of_installments: installment["NumberOfInstallments"])
          end
          product = Product.new(name: res["productName"],
                                price: res["items"][0]["sellers"][0]["commertialOffer"]["price"],
                                store_id: store.id,
                                installments: installments)
          product.save

        end

      rescue RestClient::ExceptionWithResponse => e
        e.response
      end
    end
  end
  desc "PUT in index"
end
