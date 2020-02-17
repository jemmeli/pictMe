require 'spec_helper'

RSpec.describe API::V1::RacesController, api: true, type: :controller do
  include Docs::V1::Races::Api

  let!(:event) {@event = create(:event)}
  let!(:edition) {@edition = create(:edition, event: event)}
  let!(:race) {@race = create(:race, edition: edition)}
  let(:valid_attributes) {attributes_for(:race, edition: edition)}
  let(:token) {double :acceptable? => true, resource_owner_id: nil}


  before do
    allow(controller).to receive(:doorkeeper_token) {token}
  end

  describe 'GET #index' do
    include Docs::V1::Races::Index

    it 'return a list of races for an edition', :dox do
      get :index, params: {edition_id: @edition.id}
      expect(response).to have_http_status(200)
    end

  end

  describe 'GET #show' do
    include Docs::V1::Races::Show

    context 'if the race exist' do
      it 'return the race', :dox do
        get :show, params: {id: @race.id}
        expect(response).to have_http_status(200)
      end
    end

    context "if the race doesn't exist" do
      it 'return Not found', :dox do
        get :show, params: {id: -1}
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'GET #new' do
    it 'return a  Method Not Allowed status' do
      get :new, params: {edition_id: @edition.id}
      expect(response).to have_http_status(405)
    end
  end

  describe 'GET #edit' do
    it 'return a  Method Not Allowed status' do
      get :edit, params: {id: -1}
      expect(response).to have_http_status(405)
    end
  end

  describe 'POST #create' do
    include Docs::V1::Races::Create

    context 'With valid parameters' do
      it 'create a new race for an edition', :dox do
        post :create, params: {edition_id: @edition.id, race: valid_attributes}
        expect(response).to have_http_status(201)
      end
    end

    context 'Without parameters' do
      it 'return Bad request', :dox do
        post :create, params: {edition_id: @edition.id}
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'POST #update' do
    include Docs::V1::Races::Update

    context 'With valid parameters' do
      it 'return Success', :dox do
        put :update, params: {id: @race.id, race: valid_attributes}
        expect(response).to have_http_status(200)
      end
    end

    context 'Without parameters' do
      it 'return Bad request', :dox do
        put :update, params: {id: @race.id, race: nil}
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'DELETE #destroy' do
    include Docs::V1::Races::Destroy

    context 'if the race exist' do
      it 'return No content', :dox do
        delete :destroy, params: {id: @race.id}
        expect(response).to have_http_status(204)
      end
    end

    context "if the race doesn't exist" do
      it 'return Not Found', :dox do
        delete :destroy, params: {id: -1}
        expect(response).to have_http_status(404)
      end
    end
  end

end
