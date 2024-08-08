require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  before do
    @micropost = FactoryBot.build(:micropost, user: user)
  end

  subject { @micropost }
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should be_valid }

  describe 'should be content valid' do
    before { @micropost.content = nil }
    it { should_not be_valid }
  end

  describe 'should be user valid' do
    before { @micropost.user = nil }
    it { should_not be_valid }
  end

  describe 'should be length content invalid' do
    before { @micropost.content = 'a' * 267 }
    it { should_not be_valid }
  end
end
