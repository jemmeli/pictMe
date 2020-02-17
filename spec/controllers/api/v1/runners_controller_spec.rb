require 'spec_helper'

RSpec.describe API::V1::RunnersController, api: true, type: :controller do
  include Docs::V1::Runners::Api

  let!(:runner) { @runner = create(:runner) }
  let(:valid_attributes) { attributes_for(:runner) }
  let(:invalid_attributes) { attributes_for(:runner, first_name: '') }
  let(:token) {double :acceptable? => true, resource_owner_id: nil}


  before do
    allow(controller).to receive(:doorkeeper_token) {token}
  end

  describe 'GET #index' do
    include Docs::V1::Runners::Index

    it 'return a list of runners', :dox do
      get :index
      expect(response).to have_http_status(200)
    end

  end

  describe 'GET #show' do
    include Docs::V1::Runners::Show

    context 'if the runner exist' do
      it 'return the runner', :dox do
        get :show, params: {id: @runner.id}
        expect(response).to have_http_status(200)
      end
    end

    context "if the runner doesn't exist" do
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
    include Docs::V1::Runners::Create

    context 'With valid parameters' do
      it 'create a new runner', :dox do
        post :create, params: {runner: valid_attributes}
        expect(response).to have_http_status(201)
      end
    end

    context 'With invalid parameters' do
      it 'return Unprocessable entity', :dox do
        post :create, params: {runner: invalid_attributes}
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
    include Docs::V1::Runners::Update

    context 'With valid parameters' do
      it 'return Success', :dox do
        put :update, params: {id: @runner.id, runner: valid_attributes }
        expect(response).to have_http_status(200)
      end
    end

    context 'With invalid parameters' do
      it 'return Not Modified', :dox do
        put :update, params: {id: @runner.id, runner: invalid_attributes}
        expect(response).to have_http_status(304)
      end
    end

    context 'Without parameters' do
      it 'return Bad request', :dox do
        put :update, params: {id: @runner.id, runner: nil}
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'DELETE #destroy' do
    include Docs::V1::Runners::Destroy

    context 'if the runner exist' do
      it 'return No content', :dox do
        delete :destroy, params: {id: @runner.id}
        expect(response).to have_http_status(204)
      end
    end

    context "if the runner doesn't exist" do
      it 'return Not Found', :dox do
        delete :destroy, params: {id: -1}
        expect(response).to have_http_status(404)
      end
    end
  end

end
