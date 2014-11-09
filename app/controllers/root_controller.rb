class RootController < ApplicationController
	def root
		if user_signed_in?
			redirect_to :controller => 'home', :action => 'index'
		else
			render :root
		end
	end

end
