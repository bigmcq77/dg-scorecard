require 'rails_helper'

RSpec.describe Round, :type => :model do
  it { should respond_to :weather }
  it { should belong_to :user }
  it { should belong_to :course }
  it { should have_many :scores }
end

