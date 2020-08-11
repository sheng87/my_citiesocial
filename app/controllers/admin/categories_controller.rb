class Admin::CategoriesController < Admin::BaseController
    before_action :find_category, only: [:edit, :update, :destroy,:sort]

    def index
        @categories = Category.order(position: :asc)
    end

    def new
        @category = Category.new
    end

    def create
        @category = Category.new(category_params)

        if @category.save
            redirect_to admin_categories_path, notice: '新增分類成功'
        else
            render :new
        end
        
    end

    def sort 
        @category.insert_at(params[:to].to_i+1)
        render json: {status: 'ok'}
    end
    
    def destroy
        @category.destroy
        redirect_to admin_categories_path, notice: '分類已刪除'
    end

    private
    def find_category
        @category = Category.find(params[:id])
    end

    def category_params
        params.require(:category).permit(:name)
    end
end
