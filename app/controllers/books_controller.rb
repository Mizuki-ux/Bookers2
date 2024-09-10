class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def new
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    
   if @book.save
     flash[:notice] = "You have created book successfully."
    redirect_to book_path(@book)
   else 
     @user = current_user
     @books = Book.all
    render :index
   end
  end

  def index
     @book = Book.new
    @books = Book.page(params[:page])
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
    @user = current_user
    @books = Book.page(params[:page])
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to @book, notice: 'You have updated book successfully.'
    else
      render :edit
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path(@book)
  end
  
   private

  def book_params
    params.require(:book).permit(:title,:body,:user_id)
  end
  
  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user.id == current_user.id
      redirect_to books_path
    end
  end
end

