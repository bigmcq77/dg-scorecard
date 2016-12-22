require 'rails_helper'

RSpec.describe Course, :type => :model do
  it { should respond_to :name }
  it { should respond_to :num_holes }
  it { should have_many :holes }
  it { should validate_presence_of :name }
  it { should validate_numericality_of(:num_holes).is_greater_than(0) }
end
