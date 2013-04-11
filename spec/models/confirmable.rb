require 'spec_helper'

describe Signap::Confirmable do
  class Sample
    include Mongoid::Document
    include Signap::Confirmable
  end

  let(:user) { User.new(email: "hoge@hoge.com") }


  describe ".confirmation_token" do
    it "should generate confirmation_token when persisted" do
      expect(user.confirmation_token).to be_nil
      user.save
      expect(user.confirmation_token).not_to be_nil
    end
  end

  describe ".confirm!" do
    before do
      user.save
    end

    context "when confirm succeeded" do
      before do
        user.assign_attributes(password: "password")
        expect(user).to be_valid
      end

      it "returns true" do
        expect(user.confirm!).to eql(true)
      end

      it "changes value of confirmed? to true" do
        expect(user.confirmed?).to be_false
        user.confirm!
        expect(user.confirmed?).to be_true
      end

      it "sets confirmed_at attribute" do
        expect(user.confirmed_at).to be_nil
        user.confirm!
        expect(user.confirmed_at).not_to be_nil
      end
      it "should not confirm a user alerady confirmed" do
        expect(user.confirm!).to eql(true)
        expect(user.confirm!).to eql(false)
      end
    end

    context "when confirm! failed" do
      it "returns false" do
        expect(user.confirm!).to eql(false)
      end
    end
  end
end
