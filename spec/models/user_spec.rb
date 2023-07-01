require 'rails_helper'

describe User, type: :model do
  before :each do
    @user = User.create(name: 'user01', email: 'user01@gmail.com', password: 'password01')
  end

  it 'User model field should be equal to test user' do
    expect(@user.name).to eq('user01')
    expect(@user.email).to eq('user01@gmail.com')
    expect(@user.password).to eq('password01')
  end
end