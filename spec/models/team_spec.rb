# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Team, type: :model do
  let(:original_tab) { { 'A' => 5, 'B' => 10, 'C' => 15, 'Cuauh' => 20 } }
  let(:new_tab) { { 'A' => 5, 'B' => 6, 'C' => 10, 'Cuah' => 11 } }

  describe '#new' do
    context 'when creating a team with only name' do
      it 'has the default tabulator' do
        team = described_class.new(name: 'New name', new_tab: nil)
        expect(team.tabulator).to eq(original_tab)
      end
    end

    context 'when creating a team with a new tab' do
      it 'has the default tabulator' do
        team = described_class.new(name: 'New name', new_tab: new_tab)
        expect(team.tabulator).to eq(new_tab)
      end
    end
  end

  describe '.add_scores_from_players' do
    subject(:team) { described_class.new(name: 'rojo').add_scores_from_players(goals, level) }

    let(:goals) { nil }
    let(:level) { nil }

    context 'with nil values' do
      it { is_expected.to be_nil }
    end

    context 'with valid values' do
      let(:goals) { 10 }
      let(:level) { 'C' }

      it { is_expected.to be_kind_of(Numeric) }
    end
  end

  describe '.calculate_percentage' do
    let(:once) do
      team = described_class.new(name: 'rojo')
      team.add_scores_from_players(10, 'C')
      team.calculate_percentage
    end

    let(:twice) do
      team = described_class.new(name: 'rojo')
      team.add_scores_from_players(10, 'C')
      team.calculate_percentage
      team.calculate_percentage
    end

    context 'when the percentage is calculated once' do
      it 'returns a valid percentage' do
        expect(once).to eq(66)
      end
    end

    context 'when the percentage is calculated twice' do
      it 'returns nil' do
        expect(twice).to eq(nil)
      end
    end
  end
end
