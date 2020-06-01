# frozen_string_literal: true

# Service class to calculate player payments
class PaymentService
  attr_reader :player_list, :players, :teams, :additional_info

  def initialize(player_list, tabulator_info)
    @player_list = player_list
    @additional_info = tabulator_info
    @players = []
    @teams = []
  end

  def calculate_payments
    create_teams
    create_players
    process_payments
  end

  # From the list of players we create the teams.
  # If we get additional info we make sure to override the tabs of that team
  def create_teams
    player_list.map { |item| item[:equipo] }.uniq.each do |name|
      if additional_info.blank?
        team = Team.new(name: name)
      else
        new_tab = additional_info.find { |item| item[:equipo] == name }
        team = Team.new(name: name, new_tab: new_tab.as_json(except: :equipo))
      end
      @teams << team
    end
  end

  # From the list of players we create all players and start adding
  # each individual value to each team
  def create_players
    player_list.each do |item|
      player = Player.new(item)
      player.team = find_team(player.equipo).first
      player.team.add_scores_from_players(player.goles, player.nivel)
      players << player
    end
  end

  # First we select the player team and calculate the team percentage
  # Then we calculate his indivual paycheck
  def process_payments
    players.each do |player|
      player.team.calculate_percentage
      player.calculate_paycheck
    end
  end

  private

  def find_team(name)
    teams.select { |team| team.name == name }
  end
end
