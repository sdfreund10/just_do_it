require 'rails_helper'

RSpec.describe User, type: :model do
  it "should have_many tasks" do
    should have_many(:tasks).dependent(:destroy)
  end

  it "validates name" do
    should validate_presence_of(:name)
  end
end
