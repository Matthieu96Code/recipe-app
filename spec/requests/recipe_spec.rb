require 'rails_helper'

RSpec.describe Recipe, type: :request do
  describe 'GET /recipes' do
    include Devise::Test::IntegrationHelpers

    before do
      @user = User.create(name: 'user01', email: 'user01@gmail.com', password: 'password01')
      sign_in @user
    end
    it 'should responce with success.' do
      get '/recipes'
      expect(response).to have_http_status(:success)
    end
    it 'should responce with correct status' do
      get '/recipes'
      expect(response.status).to eq(200)
    end
    it 'should render correct template' do
      get '/recipes'
      expect(response).to render_template('index')
    end
  end

  describe 'GET /recipes/:id' do
    before do
      @user = User.create(name: 'user01', email: 'user01@gmail.com', password: 'password01')
      # sign_in @user
      post '/login', params: { user: { email: @user.email, password: @user.password } }
      follow_redirect!
      @recipe = Recipe.create(user: @user, name: 'test recipe', preparation_time: 1, cooking_time: 10,
                              description: 'test test')
    end
    it 'should responce with success.' do
      get recipe_path(@recipe)
      expect(response).to have_http_status(:success)
    end
    it 'should responce with correct status' do
      get recipe_path(@recipe)
      expect(response.status).to eq(200)
    end
    it 'should render correct template' do
      get recipe_path(@recipe)
      expect(response).to render_template('show')
    end
    it 'should render correct template' do
      get recipe_path(@recipe)
      expect(response.body).to include('test recipe')
    end
  end

  describe 'POST :create' do
    before do
      @user = User.create(name: 'user01', email: 'user01@gmail.com', password: 'password01')
      post '/login', params: { user: { email: @user.email, password: @user.password } }
      follow_redirect!
    end
    it 'creates a new recipe' do
      recipe_attributes = { name: 'test recipe', preparation_time: 1, cooking_time: 10,
                            description: 'test description' }

      post '/recipes', params: { recipe: recipe_attributes }

      expect(response.status).to eq(302)
      expect(Recipe.count).to eq(1)
      expect(Recipe.last.name).to eq('test recipe')
      expect(Recipe.last.description).to eq('test description')
    end
  end

  describe 'PATCH :update' do
    before do
      @user = User.create(name: 'user01', email: 'user01@gmail.com', password: 'password01')
      post '/login', params: { user: { email: @user.email, password: @user.password } }
      follow_redirect!
      @recipe = Recipe.create(user: @user, name: 'test recipe', preparation_time: 1, cooking_time: 10,
                              description: 'test description')
    end
    it 'update recipe visibility' do
      recipe_attributes = { public: true }

      patch recipe_path(@recipe), params: { recipe: recipe_attributes }

      expect(response.status).to eq(302)
      expect(Recipe.last.public).to eq(true)
      expect(Recipe.last.name).to eq('test recipe')
      expect(Recipe.last.description).to eq('test description')
    end
  end

  describe 'DELETE :destroy' do
    before do
      @user = User.create(name: 'user01', email: 'user01@gmail.com', password: 'password01')
      post '/login', params: { user: { email: @user.email, password: @user.password } }
      follow_redirect!
      @recipe = Recipe.create(user: @user, name: 'test recipe', preparation_time: 1, cooking_time: 10,
                              description: 'test description')
    end
    it 'delete recipe' do
      delete recipe_path(@recipe)

      expect(response.status).to eq(302)
      expect(Recipe.exists?(@recipe.id)).to be_falsey
      expect(response).to redirect_to(recipes_path)
    end
  end
end