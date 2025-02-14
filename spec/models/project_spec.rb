require 'rails_helper'

RSpec.describe Project, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:comments).dependent(:destroy) }

  it 'has paper trail for status' do
    project = create(:project)
    expect(project).to respond_to(:paper_trail)
  end

  it { should define_enum_for(:status).with_values(in_progress: 0, completed: 1, pending: 2) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:status) }

  describe 'valid project' do
    let(:user) { create(:user) }
    let(:project) { build(:project, user: user) }

    it 'is valid with valid attributes' do
      expect(project).to be_valid
    end
  end

  describe 'invalid project' do
    let(:user) { create(:user) }

    it 'is invalid without a title' do
      project = build(:project, title: nil, user: user)
      expect(project).not_to be_valid
      expect(project.errors[:title]).to include("can't be blank")
    end

    it 'is invalid without a status' do
      project = build(:project, status: nil, user: user)
      expect(project).not_to be_valid
      expect(project.errors[:status]).to include("can't be blank")
    end
  end
end
