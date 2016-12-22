require 'rails_helper'

RSpec.describe Hole, :type => :model do
  it { should respond_to :number }
  it { should respond_to :par }
  it { should belong_to :course }
  it { should validate_numericality_of(:number).is_greater_than(0) }
  it { should validate_numericality_of(:par).is_greater_than(1) }
  it { should validate_uniqueness_of(:number).scoped_to(:course_id) }
end
