require 'spec_helper'

RSpec.describe API::V1::EditionsController, api: true, type: :controller do
  include Docs::V1::Editions::Api

  let!(:event) {@event = create(:event)}
  let!(:edition) { @edition = create(:edition, event: event) }
  let(:valid_attributes) { attributes_for(:edition, event: event) }
  let(:invalid_attributes) { attributes_for(:edition, template: nil, event: event) }
  let(:token) { double :acceptable? => true, resource_owner_id: nil }

  before do
    allow(controller).to receive(:doorkeeper_token) {token}
  end

  describe 'GET #index' do
    include Docs::V1::Editions::Index

    it 'return a list of editions for an event', :dox do
      get :index, params: {event_id: @event.id}
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    include Docs::V1::Editions::Show

    context 'if the edition exist' do
      it 'return the edition', :dox do
        get :show, params: {id: @edition.id}
        expect(response).to have_http_status(200)
      end
    end

    context "if the edition doesn't exist" do
      it 'return Not found', :dox do
        get :show, params: {id: -1}
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'GET #new' do
    it 'return a  Method Not Allowed status' do
      get :new, params: {event_id: @event.id}
      expect(response).to have_http_status(405)
    end
  end

  describe 'GET #edit' do
    it 'return a  Method Not Allowed status' do
      get :edit, params: {event_id: @event.id, id: -1}
      expect(response).to have_http_status(405)
    end
  end

  describe 'POST #create' do
    include Docs::V1::Editions::Create

    context 'With valid parameters' do
      it 'create a new edition for an event', :dox do
        post :create, params: { event_id: @event.id, edition: valid_attributes }
        expect(response).to have_http_status(201)
      end
    end

    context 'With invalid parameters' do
      it 'return Unprocessable entity', :dox do
        post :create, params: { event_id: @event.id, edition: invalid_attributes }
        expect(response).to have_http_status(422)
      end
    end

    context 'Without parameters' do
      it 'return Bad request', :dox do
        post :create, params: { event_id: @event.id }
        expect(response).to have_http_status(400)
      end
    end

    context 'Without Event' do
      it 'return Bad request', :dox do
        post :create, params: {edition: valid_attributes}
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST #update' do
    include Docs::V1::Editions::Update

    context 'With valid parameters' do
      it 'return Success', :dox do
        put :update, params: {id: @edition.id, edition: valid_attributes }
        expect(response).to have_http_status(200)
      end
    end

    context 'With invalid parameters' do
      it 'return Not Modified', :dox do
        put :update, params: {id: @edition.id, edition: invalid_attributes}
        expect(response).to have_http_status(304)
      end
    end
  end

  describe 'DELETE #destroy' do
    include Docs::V1::Editions::Destroy

    context 'if the edition exist' do
      it 'return No content', :dox do
        delete :destroy, params: {id: @edition.id}
        expect(response).to have_http_status(204)
      end
    end

    context "if the edition doesn't exist" do
      it 'return Not Found', :dox do
        delete :destroy, params: {id: -1}
        expect(response).to have_http_status(404)
      end
    end
  end
end
