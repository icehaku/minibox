require "rails_helper"

RSpec.describe User, type: :model do
  describe "Should Respond" do
    it { should respond_to :name }
    it { should respond_to :email }
    it { should respond_to :nickname }
    it { should respond_to :encrypted_password }
    it { should respond_to :reset_password_token }
    it { should respond_to :reset_password_sent_at }
  end

  describe "Associations" do
    it { should have_many(:sent_messages).class_name(
      'Message').with_foreign_key('author_id') }
    it { should have_many(:received_messages).class_name(
      'Message').with_foreign_key('destinatary_id') }
  end

  context "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:nickname) }
    it { should validate_uniqueness_of(:nickname) }
  end

  describe "Factory" do
    it { expect(build :user).to be_a User }
    it { expect(build :user).to be_valid }
  end
end
