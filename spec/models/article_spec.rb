require 'rails_helper'

RSpec.describe Article, type: :model do
  # Association test
  # ensure Article model has a 1:m relationship with the comment model
  it { should have_many(:comments).dependent(:destroy) }

  # validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
end
