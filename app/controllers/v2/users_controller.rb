module V2
  class UsersController < ApplicationController
    def index
      json_response(message: 'Hello there')
    end
  end
end
