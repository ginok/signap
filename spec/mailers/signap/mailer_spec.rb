require 'spec_helper'

describe Signap::Mailer do
  describe "confirmation_instructions" do
    let(:user) { mock_model(User, email: "test@test.com", confirmation_token: "hogehogetoken") }
    let(:mail) { Signap::Mailer.confirmation_instructions(user) }

    it "renders confirmation url" do
      expect(mail.body).to include(@routes.url_for(controller: 'signap/confirmations', action: :show, host: 'localhost:3000', confirmation_token: user.confirmation_token))
    end
  end
end
