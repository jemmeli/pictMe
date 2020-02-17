require 'spec_helper'

RSpec.describe API::V1::ResultsController, api: true, type: :controller do
  include Docs::V1::Results::Api

  let!(:event) {@event = create(:event)}
  let!(:edition) {@edition = create(:edition, event: event)}
  let!(:race) {@race = create(:race, edition: edition)}
  let!(:runner) {@runner = create(:runner)}
  let!(:result) {@result = create(:result, race: race, runner: runner)}
  let(:valid_attributes) {attributes_for(:result, race: race, runner: runner)}
  let(:token) {double :acceptable? => true, resource_owner_id: nil}


  before do
    allow(controller).to receive(:doorkeeper_token) {token}
  end

  describe 'GET #index' do
    include Docs::V1::Results::Index

    context 'for a given race' do
      it 'return its list of results', :dox do
        get :index, params: {race_id: @race.id}
        expect(response).to have_http_status(200)
      end
    end

    context 'for a given runner' do
      it 'return its list of results', :dox do
        get :index, params: {runner_id: @runner.id}
        expect(response).to have_http_status(200)
      end
    end

    context 'for a given edition' do
      it 'return its list of results', :dox do
        get :index, params: {edition_id: @edition.id}
        expect(response).to have_http_status(200)
      end
    end

  end

  describe 'GET #show' do
    include Docs::V1::Results::Show

    context 'if the result exist' do
      it 'return the result', :dox do
        get :show, params: {id: @result.id}
        expect(response).to have_http_status(200)
      end
    end

    context "if the result doesn't exist" do
      it 'return Not found', :dox do
        get :show, params: {id: -1}
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'GET #new' do
    it 'return a  Method Not Allowed status' do
      get :new, params: {race_id: @race.id}
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
    include Docs::V1::Results::Create

    context 'for a race' do
      context 'With valid parameters' do
        it 'create a new result', :dox do
          post :create, params: {race_id: @race.id, result: valid_attributes}
          expect(response).to have_http_status(201)
        end
      end

      context 'Without parameters' do
        it 'return Bad request', :dox do
          post :create, params: {race_id: @race.id}
          expect(response).to have_http_status(400)
        end
      end
    end

    context 'for a runner' do
      context 'With valid parameters' do
        it 'create a new result', :dox do
          post :create, params: {runner_id: @runner.id, result: valid_attributes}
          expect(response).to have_http_status(201)
        end
      end

      context 'Without parameters' do
        it 'return Bad request', :dox do
          post :create, params: {runner_id: @runner.id}
          expect(response).to have_http_status(400)
        end
      end
    end

    context 'for an edition' do
      context 'With valid parameters' do
        it 'create a new result', :dox do
          post :create, params: {edition_id: @edition.id, result: valid_attributes}
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
  end

  describe 'POST #update' do
    include Docs::V1::Results::Update

    context 'With valid parameters' do
      it 'return Success', :dox do
        put :update, params: {id: @result.id, result: valid_attributes}
        expect(response).to have_http_status(200)
      end
    end

    context 'Without parameters' do
      it 'return Bad request', :dox do
        put :update, params: {id: @result.id, result: nil}
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'DELETE #destroy' do
    include Docs::V1::Results::Destroy

    context 'if the result exist' do
      it 'return No content', :dox do
        delete :destroy, params: {id: @result.id}
        expect(response).to have_http_status(204)
      end
    end

    context "if the result doesn't exist" do
      it 'return Not Found', :dox do
        delete :destroy, params: {id: -1}
        expect(response).to have_http_status(404)
      end
    end
  end

end
