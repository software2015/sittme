class Api::V1::BabysittersController < ApplicationController

	def index

		direction = params[:direction].present? ? params[:direction] : "forward"
		max_load = params[:max_load].present? ? params[:max_load].to_i : 5

		if direction == "forward"

			if params[:end_cursor].present?
				babysitters = Babysitter.forward_paginate(params[:end_cursor], max_load)
				if babysitters.present?
					render json: {start_cursor: babysitters.first.id, end_cursor: babysitters.last.id, babysitters: babysitters}
				else
					render json: {start_cursor: "", end_cursor: "", babysitters: []}
				end
			else
				babysitters = Babysitter.initial_paginate(max_load)
				render json: {start_cursor: babysitters.first.id, end_cursor: babysitters.last.id, babysitters: babysitters}			
			end

		elsif direction == "backward"

			if params[:start_cursor].present?
				babysitters = Babysitter.backward_paginate(params[:start_cursor], max_load)
				if babysitters.present?
					render json: {start_cursor: babysitters.last.id, end_cursor: babysitters.first.id, babysitters: babysitters}
				else
					render json: {start_cursor: "", end_cursor: "", babysitters: []}
				end
			else
				babysitters = Babysitter.initial_paginate(max_load)
				render json: {start_cursor: babysitters.last.id, end_cursor: babysitters.first.id, babysitters: babysitters}			
			end

		end

	end

	def create
		babysitter = Babysitter.new(babysitter_params)
		if babysitter.save
			render json: babysitter
		else
			render json: {errors: "Няню не удалось сохранить"}
		end
	end

	private

    def babysitter_params
      params.permit(:first_name, :last_name)
    end

end
