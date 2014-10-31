class SharedPostsController < ApplicationController
  before_action :authorize, :shared_user

  def index

  end

  def show
    @sharedPost = SharedPost.find_by_post_id(params[:id])

    if !@sharedPost
      @sharedPost = SharedPost.new
      @sharedPost.post_id = params[:id]
    end
  end

  def create
    @sharedPost = SharedPost.new(shared_post_params)

    respond_to do |format|
      if @sharedPost.save
        create_shared_users(shared_post_params)

        format.html { redirect_to root_url, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

   def update
    @sharedPost = SharedPost.find(params[:id])

    respond_to do |format|
      if @sharedPost.update(shared_post_params)
        create_shared_users(shared_post_params)

        format.html { redirect_to root_url, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'show' }
        format.json { render json: @sharedPost.errors, status: :unprocessable_entity }
      end
    end
  end

  private
   def shared_post_params
      params.require(:shared_post).permit(:post_id,:password, :users, :id)
   end

   def create_shared_users(shared_post_params)
      users = shared_post_params[:users]

      users.split(',').each do |user|
        find_user = User.find_by_email(user.strip)

        unless find_user
          shared_user = User.new(email: user.strip, password: shared_post_params[:password], role: 'shared')
          shared_user.save
        else
          # find_user.update()
        end
      end
    end
end
