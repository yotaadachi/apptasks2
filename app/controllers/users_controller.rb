class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
    @user = current_user
    @book_new = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book_new = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
       render :edit
    else
       redirect_to user_path(current_user)
    end
  end

  def update
       @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'User information was successfully updated.'
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private
  def user_params
    @_params.require(:user).permit(:name, :profile_image, :introduction, :profile_image)
  end

end
