# frozen_string_literal: true

# Team class
class Team
  attr_accessor :name, :total_scored, :total_required, :percentage, :config

  # We set the default values for resuelve FC

  def initialize(*args)
    args = args[0]
    @name = args[:name]
    @total_required = 0
    @total_scored = 0
    @tabulator = { 'A' => 5, 'B' => 10, 'C' => 15, 'Cuauh' => 20 }
    @percentage = 0
  end

  # Team percentage calculation

  def calculate_percentage
    return unless percentage.zero?

    @percentage = (total_scored * 100) / total_required
  end

  # Add the scores from the players of the same team
  # so we can calculate the percentage of the team

  def add_scores_from_players(goals, level)
    @total_scored = total_scored + goals
    @total_required = total_required + tabulator[level]
  end
end
