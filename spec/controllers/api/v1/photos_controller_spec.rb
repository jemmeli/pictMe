require 'spec_helper'

RSpec.describe API::V1::PhotosController, api: true, type: :controller do
  include Docs::V1::Photos::Api

  let!(:event) {@event = create(:event)}
  let!(:edition) {@edition = create(:edition, event: event)}
  let!(:race) {@race = create(:race, edition: edition)}
  let!(:photo) {@photo = create(:photo, race: race)}
  let(:valid_attributes) {attributes_for(:photo, race: race)}
  let(:token) {double :acceptable? => true, resource_owner_id: nil}


  before do
    allow(controller).to receive(:doorkeeper_token) {token}
  end

  describe 'GET #index' do
    include Docs::V1::Photos::Index

    context 'for a given race' do
      it 'return its list of photos', :dox do
        get :index, params: {race_id: @race.id}
        expect(response).to have_http_status(200)
      end
    end


    context 'for a given edition' do
      it 'return its list of photos', :dox do
        get :index, params: {edition_id: @edition.id}
        expect(response).to have_http_status(200)
      end
    end

  end

  describe 'GET #show' do
    include Docs::V1::Photos::Show

    context 'if the photo exist' do
      it 'return the photo', :dox do
        get :show, params: {id: @photo.id}
        expect(response).to have_http_status(200)
      end
    end

    context "if the photo doesn't exist" do
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
    include Docs::V1::Photos::Create

    context 'for a race' do
      context 'With valid parameters' do
        it 'create a new photo', :dox do
          post :create, params: {race_id: @race.id, photo: valid_attributes}
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

    context 'for an edition' do
      context 'With valid parameters' do
        it 'create a new photo', :dox do
          post :create, params: {edition_id: @edition.id, photo: valid_attributes}
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
    include Docs::V1::Photos::Update

    context 'With valid parameters' do
      it 'return Success', :dox do
        put :update, params: {id: @photo.id, photo: valid_attributes}
        expect(response).to have_http_status(200)
      end
    end

    context 'Without parameters' do
      it 'return Bad request', :dox do
        put :update, params: {id: @photo.id, photo: nil}
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'DELETE #destroy' do
    include Docs::V1::Photos::Destroy

    context 'if the photo exist' do
      it 'return No content', :dox do
        delete :destroy, params: {id: @photo.id}
        expect(response).to have_http_status(204)
      end
    end

    context "if the photo doesn't exist" do
      it 'return Not Found', :dox do
        delete :destroy, params: {id: -1}
        expect(response).to have_http_status(404)
      end
    end
  end

end
