require 'spec_helper'

describe Signap::SecurePassword do
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

  it "can assign string as password" do
    subject.password = "password"
    expect(subject.password).to eql("password")
  end

  it "can assign string as password_confirmation" do
    subject.password_confirmation = "password"
    expect(subject.password_confirmation).to eql("password")
  end

  it "assigns password_digest when password is assigned" do
    expect(subject.password_digest).to be_nil
    subject.password = "password"
    expect(subject.password_digest).to be_true
  end

  context "in case of creation" do
    it "allows nil for password_digest" do
      subject.password_digest = nil
      expect(subject).to be_valid
    end

    it "fails validation when password does not match to confirmation" do
      subject.password = "password"
      subject.password_confirmation = "not match"
      expect(subject).not_to be_valid
    end
  end

  context "incase of update" do
    before { expect(subject.save).to be_true }

    it "requires password_digest to be presence" do
      subject.password_digest = nil
      expect(subject).not_to be_valid
    end

    it "should not allows blank password" do
      subject.password = ""
      expect(subject).not_to be_valid
    end

    it "should not allows blank password in case of mass-assignment" do
      subject.assign_attributes(password: "")
      expect(subject).not_to be_valid
    end
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

    it "returns false when password_digest is nil" do
      subject.password_digest = nil
      expect(subject.authenticate("password")).to be_false
    end
  end
end
