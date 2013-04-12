require 'spec_helper'

describe Signap::ConfirmationsController do
  let(:token) { "hogehoge" }
  let(:confirmable) { stub_model(User) }

  describe "GET show" do
    it "finds confirmable by specified token" do
      User.should_receive(:find_unconfirmed_confirmable).with(token).and_return(confirmable)
      get :show, use_route: :signap, confirmation_token: token
    end

    context "when confirmable found" do
      before do
        User.stub(:find_unconfirmed_confirmable).and_return(confirmable)
      end

      it "renders :show template" do
        get :show, use_route: :signap
        expect(response).to render_template :show
      end

      it "assigns confirmable.token as @confirmation_token" do
        confirmable.stub(:confirmation_token).and_return(token)
        get :show, use_route: :signap
        expect(assigns(:confirmation_token)).to eql(token)
      end
    end

    context "when confirmable not found" do
      before do
        User.stub(:find_unconfirmed_confirmable).and_return(false)
      end

      it "redirects to confirmations#new" do
        get :show, use_route: :signap
        expect(response).to redirect_to new_confirmation_path
      end
    end
  end

  describe "PATCH update" do
    before do
      @params
      controller.stub(:confirm_params).and_return(@params)
    end

    it "finds confirmable by specified token" do
      User.should_receive(:find_unconfirmed_confirmable).with(token).and_return(confirmable)
      patch :update, use_route: :signap, confirmation_token: token
    end

    context "when confirmable found" do
      before do
        User.stub(:find_unconfirmed_confirmable).and_return(confirmable)
      end

      it "confirms the confirmable if it is valid" do
        confirmable.stub(:valid?).and_return(true)
        confirmable.should_receive(:confirm!)
        patch :update, use_route: :signap
      end

      context "when the confirmable is not valid" do
        before do
          confirmable.stub(:valid?).and_return(false)
        end

        it "renders :show template" do
          patch :update, use_route: :signap
          expect(response).to render_template :show
        end

        it "assigns confirmable.token as @confirmation_token" do
          confirmable.stub(:confirmation_token).and_return(token)
          patch :update, use_route: :signap
          expect(assigns(:confirmation_token)).to eql(token)
        end
      end
    end

    context "when confirmable not found" do
      before do
        User.stub(:find_unconfirmed_confirmable).and_return(false)
      end

      it "redirects to confirmations#new" do
        patch :update, use_route: :signap
        expect(response).to redirect_to new_confirmation_path
      end
    end
  end
end
