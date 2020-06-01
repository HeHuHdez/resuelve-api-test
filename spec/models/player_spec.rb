# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Player, type: :model do
  let(:player) do
    {
      "nombre": 'Juan Perez',
      "nivel": 'C',
      "goles": 10,
      "sueldo": 50_000,
      "bono": 25_000,
      "sueldo_completo": nil,
      "equipo": 'rojo'
    }
  end

  describe '.calculate_paycheck' do
    let(:team) do
      team = Team.new(name: 'rojo', new_tab: new_tab)
      team.add_scores_from_players(10, 'C')
      team.calculate_percentage
      team
    end

    context 'without team' do
      it 'returns nil' do
        expect(described_class.new(player).calculate_paycheck).to be_nil
      end
    end

    context 'with the default tabulator' do
      let(:new_tab) { nil }

      it 'returns 66_500' do
        new_player = described_class.new(player)
        new_player.team = team
        expect(new_player.calculate_paycheck).to eq(66_500)
      end
    end

    context 'with different tabulator' do
      let(:new_tab) { { 'A' => 5, 'B' => 6, 'C' => 10, 'Cuah' => 11 } }

      it 'returns 66_500' do
        new_player = described_class.new(player)
        new_player.team = team
        expect(new_player.calculate_paycheck).to eq(75_000)
      end
    end
  end
end
