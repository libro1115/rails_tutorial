class BooksController < ApplicationController
    def index
        @books = Book.all
    end

    def show
        @book = Book.find(params[:id])
    end

    def new
        @book = Book.new
        @book.year = 2022
    end

    def create
        book_params = params.require(:book).permit(:year, :month,:inout,:category,:amount)
        @book = Book.new(book_params)
        respond_to do |format|
            if @book.save
                format.html{redirect_to books_path(@book),notice:"Book was successfully created"}
                format.json{render:show, status: :created, location: @book}
            else
                format.html{render:new, status: :unprocessable_entity}
                format.json{render json:@book.errors, status: :unprocessable_entity}
            end
        end
    end

    def edit
        @book = Book.find(params[:id])
    end

    def update
        @book = Book.find(params[:id])
        book_params = params.require(:book).permit(:year,:month,:inout,:category,:amount)
        if @book.update(book_params)
                redirect_to books_path
        else 
            render :edit
        end
    end
    
    def destroy
        @book = Book.find(params[:id])
        @book.destroy
        redirect_to do |f|
            f.html{redirect_to books_path, notice:"Task was destoryed",status: :see_other}
            f.json{head:no_content}
        end
    end
end