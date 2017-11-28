class BooksController < ApplicationController
    include ActionController::HttpAuthentication::Token::ControllerMethods
    # before_action :restrict_access
    before_action :restrict_access

    def index

        


    end




    def search
        client = Goodreads::Client.new(Goodreads.configuration)
        @goodread_data = client.search_books(params[:qr])
        @arr = []
        @goodread_data.results.work.map do | bookOne |
            @arr.push({
                    "book_id": bookOne.best_book.id,
                    "cat": ["book","hardcover"],
                    "name": bookOne.best_book.title,
                    "author": bookOne.best_book.author.name,
                    "series_t": "Game of thrones",
                    "sequence_i": 1,
                    "genre_s": "fantasy",
                    "inStock": true,
                    "price": bookOne.average_rating,
                    "pages_i": 384,
                    "image_url":bookOne.best_book.small_image_url
            })

        end
        render json: {
            all_books: @arr,
            status:200
        }
        
    end

    def save_books
        @book = @user.books.new(books_params)
       
        if @book.save
            render json: {
                book:{
                    all_books: @book,
                    msg: "Book saved successfully"
                },
                status:200
            }
        else
            render json: {
                errors:{
                    msg: "Something went wrong! Please try again"
                },
                status:400
            }
        end
    end



    def restrict_access
        authenticate_or_request_with_http_token do |token ,options|
           @user = User.find_by_authentication_token(token)
           @current_user = @user if @user.present?
        end
    end

    private

    def books_params
        params.require(:data).permit(:book_id,:user_id,:book_id,:name,:author,:series_t,:price)
    end



end


# render json: {
        #     all_books: [{
                # "id": "978-0641723445",
                # "cat": ["book","hardcover"],
                # "name": "The Lightning Thief",
                # "author": "Peter Dinkelege",
                # "series_t": "Game of thrones",
                # "sequence_i": 1,
                # "genre_s": "fantasy",
                # "inStock": true,
                # "price": 12.50,
                # "pages_i": 384
        #      },
        #      {
        #         "id": "978-1423103349",
        #         "cat": ["book","paperback"],
        #         "name": "The Sea of Monsters",
        #         "author": "Rick Riordan",
        #         "series_t": "Percy Jackson and the Olympians",
        #         "sequence_i": 2,
        #         "genre_s": "fantasy",
        #         "inStock": true,
        #         "price": 6.49,
        #         "pages_i": 304

        #     }],
        #     status:200
        # }