require 'spec_helper'

RSpec.describe API::V1::EventsController, api: true, type: :controller do
  include Docs::V1::Events::Api

  let!(:event) { @event = create(:event) }
  let(:valid_attributes) { attributes_for(:event) }
  let(:invalid_attributes) { attributes_for(:event, name: '') }
  let(:token) {double :acceptable? => true, resource_owner_id: nil}


  before do
    allow(controller).to receive(:doorkeeper_token) {token}
  end

  describe 'GET #index' do
    include Docs::V1::Events::Index

    it 'return a list of events', :dox do
      get :index
      expect(response).to have_http_status(200)
    end

  end

  describe 'GET #show' do
    include Docs::V1::Events::Show

    context 'if the event exist' do
      it 'return the event', :dox do
        get :show, params: {id: @event.id}
        expect(response).to have_http_status(200)
      end
    end

    context "if the event doesn't exist" do
      it 'return Not found', :dox do
        get :show, params: {id: -1}
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'GET #new' do
    it 'return a  Method Not Allowed status' do
      get :new, params: {}
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
    include Docs::V1::Events::Create

    context 'With valid parameters' do
      it 'create a new event', :dox do
        post :create, params: {event: valid_attributes}
        expect(response).to have_http_status(201)
      end
    end

    context 'With invalid parameters' do
      it 'return Unprocessable entity', :dox do
        post :create, params: {event: invalid_attributes}
        expect(response).to have_http_status(422)
      end
    end

    context 'Without parameters' do
      it 'return Bad request', :dox do
        post :create
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'POST #update' do
    include Docs::V1::Events::Update

    context 'With valid parameters' do
      it 'return Success', :dox do
        put :update, params: {id: @event.id, event: valid_attributes }
        expect(response).to have_http_status(200)
      end
    end

    context 'With invalid parameters' do
      it 'return Not Modified', :dox do
        put :update, params: {id: @event.id, event: invalid_attributes}
        expect(response).to have_http_status(304)
      end
    end

    context 'Without parameters' do
      it 'return Bad request', :dox do
        put :update, params: {id: @event.id, event: nil}
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'DELETE #destroy' do
    include Docs::V1::Events::Destroy

    context 'if the event exist' do
      it 'return No content', :dox do
        delete :destroy, params: {id: @event.id}
        expect(response).to have_http_status(204)
      end
    end

    context "if the event doesn't exist" do
      it 'return Not Found', :dox do
        delete :destroy, params: {id: -1}
        expect(response).to have_http_status(404)
      end
    end
  end

end
