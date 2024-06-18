module Api
    module V1
      class CategoriesController < ApplicationController
        def index 
            # binding.pry
            @categories = Category.all
            render json: { status: 'success', message: 'Loaded categories successfully', data: @categories }, status: :ok
        end
        def show
            @category = Category.find(params[:id])
            render json: { status: 'success', message: 'Loaded category successfully', data: @category }, status: :ok
        end
        def create
            # binding.pry
            @category = Category.new(category_params)
            if @category.save
                render json: { status:'success', message: 'Saved category successfully', data: @category }, status: :ok
            else 
                render json: { status: 'error', message: 'Category not saved', data: @category.errors }, status: :unprocessable_entity
            end
        end

        def destroy
            @article = Category.find(params[:id])
            if @article.destroy
                render json: { status:'success', message: 'Deleted article successfully', data: @article }, status: :ok
            else 
                render json: { status: 'error', message: 'Category not deleted', data: @article.errors }, status: :unprocessable_entity
            end
        end

        def update
            @category = Category.find(params[:id])
            if @category.update(category_params)
                render json: { status:'success', message: 'Updated category successfully', data: @category }, status: :ok
            else
                render json: { status: 'error', message: 'Category not updated', data: @category.errors }, status: :unprocessable_entity
            end
        end

        private
        def category_params
            params.require(:category).permit(:category_name)
        end
      end
    end
  end
  