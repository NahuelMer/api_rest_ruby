class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token

    before_action :check_token

    def check_token
        return if request.headers["Authorization"] == "1234"
        render status: 400, json: { message: "Invalid Token" }
        false
    end
end
