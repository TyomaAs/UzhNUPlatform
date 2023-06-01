class MainController < ApplicationController
	before_action :redirect_if_not_authenticated, only: [:index]
	def index
		@courses = Course.all
	end

	def login
	end
end
