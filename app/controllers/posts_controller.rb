class PostsController < ApplicationController
    before_action :find_post, only: [:edit, :update, :show, :delete]
    before_action :authenticate_admin!, except: [:index, :show]

# Index action to render all posts
def index
    @posts = Post.all
end

# New action for creating post
def new
    @post = Post.new
end

# Create action saves the post into database
def create
    @post = Post.new(post_params)
    if @post.save
        flash[:notice] = "Successfully created post!"
        redirect_to post_path(@post)
    else
        flash[:alert] = "Error creating new post!"
        render :new
    end
end

# Edit action retrieves the post and renders the edit page
def edit
    @post = Post.find(params[:id])
end

# Update action updates the post with new information
def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
        flash[:notice] = "Successfully updated post!"
        redirect_to post_path(find_post)
    else
        flash[:alert] = "Error updating post!"
        render :edit
    end
end

# The show action renders the individual post after retrieving the id
def show
end

# The destroy action removes the post permanently from the database
def destroy
    @post = Post.find(params[:id])
    if @post.destroy
        flash[:notice] = "Successfully deleted post!"
        redirect_to posts_path
    else
        flash[:alert] = "Error deleting post!"
    end
end

private

def post_params
    params.require(:post).permit(:title, :body)
    end

def find_post
    @post = Post.find(params[:id])
    end

end

