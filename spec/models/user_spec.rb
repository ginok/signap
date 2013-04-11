require 'spec_helper'

describe User do
  context 'when signing up' do
    it { should validate_presence_of(:email) }
    it { should allow_value('test@test.com').for(:email) }
    it { should allow_value('test+something@test.com').for(:email) }
    it { should_not allow_value('test@com').for(:email) }
    it { should_not allow_value('test@test..com').for(:email) }
    it { should_not allow_value('test@.test.com').for(:email) }
    it { should_not allow_value('test').for(:email) }
    it { should_not allow_value('test.com').for(:email) }
  end

  context 'when multiple users have signed up' do
    before { User.create!(email: "hoge@hoge.com") }
    it { should validate_uniqueness_of(:email) }
  end

  context 'when update' do
    subject { User.create!(email: "hoge@hoge.com") }
    it { should validate_presence_of(:password_digest) }
  end
end
