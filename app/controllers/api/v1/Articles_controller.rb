module Api
    module V1
      class ArticlesController < ApplicationController
        def index 
            # binding.pry
            page = params[:page].to_i 
            if page<=0 
                page=1
            end
            @per_page = 4  
            puts page
            offset = (page - 1) * @per_page  
            if params[:key]
                @articles = Article.where("article_title LIKE ?", "%#{params[:key]}%").limit(@per_page).offset(offset)
            else 
                @articles = Article.limit(@per_page).offset(offset)
            end
            render json: { status: 'success', message: 'Loaded articles successfully', data: @articles }, status: :ok
        end
        def show
            @article = Article.find(params[:id])
            render json: { status: 'success', message: 'Loaded article successfully', data: @article }, status: :ok
        end
        def create
            # binding.pry
            @article = Article.new(article_params)
            if @article.save
                render json: { status:'success', message: 'Saved article successfully', data: @article }, status: :ok
            else 
                render json: { status: 'error', message: 'Article not saved', data: @article.errors }, status: :unprocessable_entity
            end
        end

        def destroy
            @article = Article.find(params[:id])
            if @article.destroy
                render json: { status:'success', message: 'Deleted article successfully', data: @article }, status: :ok
            else 
                render json: { status: 'error', message: 'Article not deleted', data: @article.errors }, status: :unprocessable_entity
            end
        end

        def update
            @article = Article.find(params[:id])
            if @article.update(article_params)
                render json: { status:'success', message: 'Updated article successfully', data: @article }, status: :ok
            else
                render json: { status: 'error', message: 'Article not updated', data: @article.errors }, status: :unprocessable_entity
            end
        end

        private
        def article_params
            params.require(:article).permit(:article_title, :article_content)
        end
      end
    end
  end
  