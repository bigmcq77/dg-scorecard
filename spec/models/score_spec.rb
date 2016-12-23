require 'rails_helper'

RSpec.describe Score, :type => :model do
  it { should belong_to :round }
  it { should belong_to :hole }
  it { should validate_numericality_of(:strokes).is_greater_than(0) }
  it { should validate_uniqueness_of(:hole_id).scoped_to(:round_id) }
end
