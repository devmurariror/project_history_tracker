require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:project) { create(:project) }
  let(:valid_attributes) { { text: "This is a comment." } }
  let(:invalid_attributes) { { text: "" } }

  before do
    sign_in user
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new comment and redirects to the project" do
        expect {
          post :create, params: { project_id: project.id, comment: valid_attributes }
        }.to change(project.comments, :count).by(1)

        expect(response).to redirect_to(project_path(project))
        expect(flash[:notice]).to eq('Comment added successfully.')
      end
    end

    context "with invalid attributes" do
      it "does not create a comment and redirects to the project with an error message" do
        expect {
          post :create, params: { project_id: project.id, comment: invalid_attributes }
        }.to_not change(project.comments, :count)

        expect(response).to redirect_to(project_path(project))
        expect(flash[:alert]).to eq('Failed to add comment.')
      end
    end
  end
end
