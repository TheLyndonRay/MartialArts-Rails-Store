ActiveAdmin.register Product do

  batch_action :flag do |selection|
    Post.find(selection).each { |p| p.flag! }
    redirect_to collection_path, :notice => "Posts flagged!"
  end

  index do
    column :id
    column :category_id
    column :description
    column :name
    column :price
    column :stock_quantity
    column "Image" do |image|
      image_tag image.image
    end

    default_actions
  end


  
end
