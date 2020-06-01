# frozen_string_literal: true

# Team class
class Team
  attr_accessor :name, :required, :scored, :tabulator, :percentage

  # We set the default values for resuelve FC
  # unless we receive a new_tab argument for our tabulator

  def initialize(*args)
    args = args[0]
    @name = args[:name]
    @required = 0
    @scored = 0
    @tabulator = args[:new_tab] || { 'A' => 5, 'B' => 10, 'C' => 15, 'Cuauh' => 20 }
    @percentage = 0
  end

  # Team percentage calculation

  def calculate_percentage
    return unless percentage.zero?

    @percentage = (scored * 100) / required
  end

  # Add the scores from the players of the same team
  # so we can calculate the percentage of the team

  def add_scores_from_players(goals, level)
    return unless [goals, level].all?

    @scored += goals
    @required += tabulator[level]
  end
end
