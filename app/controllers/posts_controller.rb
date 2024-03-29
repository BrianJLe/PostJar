class PostsController < ApplicationController
    # GET /posts
    # GET /posts.json

    before_filter :authenticate_user!, only: [:create, :new, :edit, :destroy]

    def index
        #@posts = current_user.posts


        Rails.logger.info("Post:  #{params.inspect}")
        if params[:post_filters]
          post_relation = Post.find_with_filters(params[:post_filters])
      end

      @posts = post_relation.page(selected_page).per(14)

      if request.xhr?
          render partial: "posts/index/space_list", locals: {posts: @posts}
      else
          render :index
      end

  end

    # GET /posts/1
    # GET /posts/1.json
    def show
        @comment = Comment.new
        @post = Post.find(params[:id])
        @comments = @post.comments

        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @post }
        end
    end

    # GET /posts/new
    # GET /posts/new.json
    def new
        @post = Post.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @post }
        end
    end

    # GET /posts/1/edit
    def edit
        @post = Post.find(params[:id])
    end

    # POST /posts
    # POST /posts.json
    def create
        @post = Post.new(params[:post])
        @post.user = current_user

        respond_to do |format|
            if @post.save
                format.html { redirect_to @post, notice: 'Post was successfully created.' }
                format.json { render json: @post, status: :created, location: @post }
            else
                format.html { render action: "new" }
                format.json { render json: @post.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /posts/1
    # PUT /posts/1.json
    def update
        @post = Post.find(params[:id])

        respond_to do |format|
            if @post.update_attributes(params[:post])
                format.html { redirect_to @post, notice: 'Post was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @post.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /posts/1
    # DELETE /posts/1.json
    def destroy
        @post = Post.find(params[:id])
        @post.destroy

        respond_to do |format|
            format.html { redirect_to posts_url }
            format.json { head :no_content }
        end
    end
end
