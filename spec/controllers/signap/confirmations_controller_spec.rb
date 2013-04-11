require 'spec_helper'

describe Signap::ConfirmationsController do
  describe "GET show" do
    let(:token) { "hogehoge" }
    let(:confirmable) { stub_model(User) }

    before do
      User.stub(:find_by).and_return(confirmable)
    end

    it "finds confirmable by specified token" do
      User.should_receive(:find_by).with(confirmation_token: token).and_return(confirmable)
      get :show, use_route: :signap, confirmation_token: token
    end

    context "when confirmable is not yet confirmed" do
      before do
        confirmable.stub(:confirmed?, false)
      end

      it "renders :show template" do
        get :show, use_route: :signap
        expect(response).to render_template :show
      end
    end

    context "when confirmable is already confirmed" do
      before do
        confirmable.stub(:confirmed?, true)
      end

      it "redirects to confirmations#new" do
        get :show, use_route: :signap
        expect(response).to redirect_to :new
      end
    end
  end
end
