# frozen_string_literal: true

# Player class
class Player
  attr_accessor(:nombre, :nivel, :goles, :sueldo,
                :bono, :sueldo_completo, :equipo, :team)

  def initialize(*args)
    args = args[0]
    @nombre = args[:nombre]
    @nivel  = args[:nivel]
    @goles  = args[:goles]
    @sueldo = args[:sueldo]
    @bono   = args[:bono]
    @sueldo_completo = args[:sueldo_completo]
    @equipo = args[:equipo]
  end

  # Only calculates a player paycheck if it has a team with a tabulator

  def calculate_paycheck
    return unless team.is_a?(Team)

    player_percentage = (goles * 100) / team.tabulator[nivel]
    percentage_earned = (player_percentage + team.percentage) / 2
    @sueldo_completo = sueldo + ((percentage_earned * bono) / 100)
  end

  def as_json(*)
    {
      nombre: nombre,
      nivel: nivel,
      goles: goles,
      sueldo: sueldo,
      bono: bono,
      sueldo_completo: sueldo_completo,
      equipo: equipo
    }
  end

  def to_json(*options)
    as_json(*options).to_json(*options)
  end
end
