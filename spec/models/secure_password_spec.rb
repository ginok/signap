require 'spec_helper'

describe Signap::SecurePassword do
  context "when calling has_secure_password with no options" do
    class Sample
      include Mongoid::Document
      include Signap::SecurePassword

      has_secure_password
    end

    subject { Sample.new }

    it "can assign string as password" do
      subject.password = "password"
      expect(subject.password).to eql("password")
    end

    it "assigns password_digest when password is assigned" do
      subject.password = "password"
      expect(subject.password_digest).to be_true
    end

    it "fails validation when no password is assigned" do
      expect(subject.valid?).to be_false
    end

    it "fails validation when password does not match to confirmation" do
      subject.password = "password"
      subject.password_confirmation = "not match"
      expect(subject.valid?).to be_false
    end

    describe ".authenticate" do
      before do
        subject.password = "password"
        expect(subject.save).to be_true
      end

      it "returns it self when specified password is correct" do
        expect(subject.authenticate("password")).to eql(subject)
      end

      it "returns false when specified password is not correct" do
        expect(subject.authenticate("not correct")).to eql(false)
      end
    end
  end

  context "when calling has_secure_password with options" do
    class Sample2
      include Mongoid::Document
      include Signap::SecurePassword

      has_secure_password on: :update
    end

    subject { Sample2.new }

    it "allows password to be not assigned in case of creation" do
      expect(subject.valid?).to be_true
    end

    it "requires password to be presence in case of update" do
      subject.save
      expect(subject.valid?).to be_false
      subject.password = "password"
      expect(subject.valid?).to be_true
    end

    describe ".authenticate" do
      before do
        expect(subject.save).to be_true
      end

      it "returns false when no password is set" do
        expect(subject.authenticate("password")).to be_false
      end
    end
  end
end
