require 'rails_helper'

RSpec.describe OmniauthCallbacksController, type: :controller do

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  it "calls Customer.from_omniauth" do
    user = FactoryGirl.create :facebook_user
    expect(User).to receive(:from_omniauth).and_return(user)
    get :facebook
  end

  it "redirect to sign up page if given information not enough" do
    user = FactoryGirl.build(:facebook_user, name: nil)
    allow(User).to receive(:from_omniauth).and_return(user)
    get :facebook
    expect(response).to redirect_to new_user_registration_url
  end

end
