# frozen_string_literal: true

module Api
  class PaymentsController < ApplicationController
    def create
    end

    private

    def player_params
      params.require(:_json).map do |p|
        p.permit(%i[nombre nivel goles sueldo bono sueldo_completo equipo])
      end
    end

    # We use fetch since this param will only be necessary if the user
    # wants to use a different tabulator for the given team(s)
    def team_tabulator_params
      params.fetch(:new_team_tabulator, []).map do |p|
        p.permit(%i[equipo A B C Cuah])
      end
    end
  end
end
