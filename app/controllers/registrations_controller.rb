class RegistrationsController < ApplicationController
    
    
        def create
           
            @user = User.where(email:params[:formData][:email]).first
            # binding.pry
                if @user.present?
                    render json: {
                        :errors => {
                            msg: "User is already registered with this email, Please try login",
                            status: 400
                        }
                    },status: 400
                else
                    @user = User.new(reg_params)
                    if @user.save
                        render json: {
                            :user =>{
                                email: @user.email,
                                token: @user.authentication_token,
                                msg: "No such user; check the submitted email address",
                                status: 200
                            }
                          }, status: 200
                    else
                        render json: {
                            :errors =>{
                                msg: "Something went wrong",
                                status: 400
                            }
                          }, status: 400

                    end
                    
                end
    
        end
    
    
        def destroy
    
        end


        private

    def reg_params
        params.require(:formData).permit(:username,:email,:password)

    end

    
    
    end