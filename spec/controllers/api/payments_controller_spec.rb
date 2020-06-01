# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::PaymentsController, type: :controller do
  let(:valid_params) do
    [
      {
        'nombre' => 'Juan Perez',
        'nivel' => 'C',
        'goles' => 10,
        'sueldo' => 50_000,
        'bono' => 25_000,
        'sueldo_completo' => nil,
        'equipo' => 'rojo'
      },
      {
        'nombre' => 'EL Cuauh',
        'nivel' => 'Cuauh',
        'goles' => 30,
        'sueldo' => 100_000,
        'bono' => 30_000,
        'sueldo_completo' => nil,
        'equipo' => 'azul'
      },
      {
        'nombre' => 'Cosme Fulanito',
        'nivel' => 'A',
        'goles' => 7,
        'sueldo' => 20_000,
        'bono' => 10_000,
        'sueldo_completo' => nil,
        'equipo' => 'azul'

      },
      {
        'nombre' => 'El Rulo',
        'nivel' => 'B',
        'goles' => 9,
        'sueldo' => 30_000,
        'bono' => 15_000,
        'sueldo_completo' => nil,
        'equipo' => 'rojo'

      }
    ]
  end

  describe 'POST /api/payments/' do
    context 'when the request has no body' do
      before do
        post :create
      end

      it 'returns 400 response' do
        expect(response).to have_http_status(400)
      end

      it 'provides an error message due missing params' do
        expect(json_body['error']).to include('param is missing or the value is empty')
      end
    end

    context 'when the request has a valid body and no new tabulator' do
      before do
        post :create, params: { _json: valid_params }, as: :json
      end

      it 'returns 200 response' do
        expect(response).to have_http_status(:success)
      end

      it 'returns the sueldo_completo of Juan Perez' do
        expect(json_body[0]['sueldo_completo']).to eq(67_750)
      end

      it 'returns the sueldo_completo of EL Cuauh' do
        expect(json_body[1]['sueldo_completo']).to eq(144_700)
      end

      it 'returns the sueldo_completo of Cosme Fulanito' do
        expect(json_body[2]['sueldo_completo']).to eq(34_400)
      end

      it 'returns the sueldo_completo of El Rulo' do
        expect(json_body[3]['sueldo_completo']).to eq(42_450)
      end
    end

    context 'when the request has a valid body and new tabulator' do
      let(:new_tab) do
        [
          {
            'equipo' => 'rojo',
            'A' => 50,
            'B' => 100,
            'C' => 150,
            'Cuauh' => 200
          }
        ]
      end

      before do
        post :create, params: { _json: valid_params, new_team_tabulator: new_tab }, as: :json
      end

      it 'returns 200 response' do
        expect(response).to have_http_status(:success)
      end

      it 'returns the sueldo_completo of Juan Perez' do
        expect(json_body[0]['sueldo_completo']).to eq(51_500)
      end

      it 'returns the sueldo_completo of EL Cuauh' do
        expect(json_body[1]['sueldo_completo']).to eq(144_700)
      end

      it 'returns the sueldo_completo of Cosme Fulanito' do
        expect(json_body[2]['sueldo_completo']).to eq(34_400)
      end

      it 'returns the sueldo_completo of El Rulo' do
        expect(json_body[3]['sueldo_completo']).to eq(31_200)
      end
    end
  end
end
