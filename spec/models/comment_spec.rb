require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to(:project) }
  it { should belong_to(:user) }

  it { should validate_presence_of(:text) }

  it 'tracks changes to text' do
    comment = create(:comment, text: 'Initial Comment')

    expect(comment.versions.count).to eq(1)

    comment.update(text: 'Updated Comment')
    expect(comment.versions.count).to eq(2)
    expect(comment.versions.last.object['text']).to eq('text')
  end
end
