# frozen_string_literal: true

module Api
  # Payment controller
  class PaymentsController < ApplicationController
    def index
      render json: { message: 'Test api for resuelve' }
    end

    def create
      payments = PaymentService.new(player_params, team_tabulator_params)
                               .calculate_payments
      render json: payments
    end

    private

    def player_params
      params.require(:_json).map do |p|
        p.require(%i[nombre nivel goles sueldo bono equipo])
        p.permit(%i[nombre nivel goles sueldo bono sueldo_completo equipo])
      end
    end

    # We use fetch since this param will only be necessary if the user
    # wants to use a different tabulator for the given team(s)
    def team_tabulator_params
      params.fetch(:new_team_tabulator, []).map do |p|
        p.require(%i[equipo A B C Cuauh])
        p.permit(%i[equipo A B C Cuauh])
      end
    end
  end
end
