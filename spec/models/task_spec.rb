require 'rails_helper'

RSpec.describe Task, type: :model do
  it "belongs to a user" do
    should belong_to(:user)
  end

  it "validates title, status" do
    validate_presence_of(:title)
    validate_presence_of(:status)
  end
end
