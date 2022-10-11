class BooksController < ApplicationController
    before_action:set_book,only:[:show,:edit,:update,:destroy]
    def index
        @books = Book.all
        @books = @books.where(year:params[:year])if params[:year].present?
        @books = @books.where(month:params[:month])if params[:month].present?
    end

    def show
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
    end

    def update
        book_params = params.require(:book).permit(:year,:month,:inout,:category,:amount)
        redirect_to do |f|
            if @book.update(book_params)
                flash[:notice]="データを1件更新"
                redirect_to books_path
                f.html{redirect_to edit_book_path(@book)}
            else 
                flash.now[:error]="データの更新に失敗"
                render :edit
                f.html{redirect_to books_path}
            end
        end
    end
    
    def destroy
        set_book
        @book.destroy
        redirect_to do |f|
            flash[:notice]="1件のデータを削除"
            f.html{redirect_to books_path, notice:"Task was destoryed",status: :see_other}
            f.json{head:no_content}
        end
    end

    private
    def set_book
        @book=Book.find(params[:id])
    end
end