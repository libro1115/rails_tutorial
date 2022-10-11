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
                flash[:notice]="データ登録に成功"
                format.html{redirect_to books_path(@book),notice:"1件のデータ登録"}
                format.json{render:show, status: :created, location: @book}
            else
                flash[:error]="データ登録に失敗"
                format.html{render:new, error:"データ登録に失敗", status: :unprocessable_entity}
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
            flash[:notice]="データを1件更新"
            redirect_to books_path
        else 
            flash.now[:error]="データの更新に失敗"
            render :edit
        end
    end
    
    def destroy
        @book = Book.find(params[:id])
        @book.destroy
        redirect_to do |f|
            flash[:notice]="1件のデータを削除"
            f.html{redirect_to books_path, notice:"Task was destoryed",status: :see_other}
            f.json{head:no_content}
        end
    end
end