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
                    UserMailer.signup_confirmation(@user).deliver
                    if @user.save
                        render json: {
                            :user =>{
                                email: @user.email,
                                token: @user.authentication_token,
                                msg: "Registration Successful",
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


        def confirmation
            @user = User.where(encrypted_password: params[:token]).first
            if @user.present? && !@user.confirmed
                @user.confirmed = true
                @user.save!
                render json: {
                    user: {
                        email: @user.email,
                        token: @user.authentication_token,
                        msg: "Registration Successful",
                        status: 200
                    },
                    status: 200
                }
            else
                render json: {
                    :errors =>{
                        msg: "Confirmation token not matched or you are already confirmed",
                        status: 400
                    }
                    }, status: 400
            end
        end
    
    
        def destroy
    
        end
        def password_reset
            render json: {
                :errors =>{
                    msg: "No Email found for password reset",
                    status: 400
                }
                }, status: 200
        end

        def validate_token
            render json: {
                :errors =>{
                    msg: "No Email found for password reset",
                    status: 400
                }
                }, status: 200
        end

        def password_reset_form
            render json: {
                :errors =>{
                    msg: "No Email found for password reset",
                    status: 400
                }
                }, status: 200
        end


        private

    def reg_params
        params.require(:formData).permit(:username,:email,:password)

    end

    
    
    end