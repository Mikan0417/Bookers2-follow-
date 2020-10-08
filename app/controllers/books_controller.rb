class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def index
    @book = Book.new
    @books = Book.all
    @users = User.all
    @user = current_user
    @favorite = Favorite.new
  end
  
  def show
    @book = current_user.books.build
    @book_new = Book.new
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
    @favorite = Favorite.new
    @book_comment = BookComment.new
  end
  
  def new
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render :"index"
    end
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "You have updated book successfully."
    else
      render 'edit'
      flash[:danger]= "Book"
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
  
  private
    def book_params
      params.require(:book).permit(:title, :body)
    end
  
    def correct_user
      @book = Book.find(params[:id])
      if current_user != @book.user
        redirect_to books_path
      end
    end
end
