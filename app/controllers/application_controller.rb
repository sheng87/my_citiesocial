class ApplicationController < ActionController::Base

before_action :find_categories, nuless: :backend?

rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
private
    def record_not_found
    render file: "#{Rails.root}/public/404.html",
        layout: false,
        status: 404
    end    

    def backend?
        controller_path.split('/').first == 'Admimn'
    end

    def find_categories
        @categories = Category.order(position: :asc)
    end
end
