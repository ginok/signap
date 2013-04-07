require 'spec_helper'

describe Signap::UsersController do
  describe "GET new" do
    before { get :new, use_route: :signap }

    it { expect(response).to be_success }
    it { expect(response).to render_template(:new) }
    it { expect(assigns(:user)).to be_new_record }
  end

  describe "POST create" do
    let(:user) { mock_model(User).as_null_object }

    it "calls User#new with params" do
      params = {"email" => "hoge@hoge.com"}
      User.should_receive(:new).with(params).and_return(user)
      post :create, user: params, use_route: :signap
    end
  end
end
