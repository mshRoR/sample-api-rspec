require 'rails_helper'

RSpec.describe Comment, type: :model do
  # Association test
  # ensure and comment record belongs to a single article record
  it { should belong_to(:article) }

  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:body) }
end
