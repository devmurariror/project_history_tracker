require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user, status: :in_progress) }

  before do
    sign_in user
  end

  describe "GET #index" do
    it "assigns all projects to @projects" do
      project1 = create(:project, user: user, status: :in_progress)
      project2 = create(:project, user: user, status: :completed)

      get :index
      expect(assigns(:projects)).to match_array([project, project1, project2])
    end
  end

  describe "GET #show" do
  it "assigns history sorted by created_at" do
    project.update(title: "First update")
    project.update(title: "Second update")

    get :show, params: { id: project.id }

    versions = project.versions.order(created_at: :desc)
    expect(assigns(:history)).to eq(versions)
  end
end


  describe "GET #new" do
    it "assigns a new project to @project" do
      get :new
      expect(assigns(:project)).to be_a_new(Project)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new project and redirects to show" do
        expect {
          post :create, params: { project: { title: 'New Project', description: 'Project Description', status: :pending } }
        }.to change(Project, :count).by(1)
        expect(response).to redirect_to(project_path(assigns(:project)))
        expect(flash[:notice]).to eq('Project created successfully.')
      end
    end

    context "with invalid params" do
      it "does not create a new project and re-renders new template" do
        expect {
          post :create, params: { project: { title: '', description: 'Project Description', status: :pending } }
        }.to_not change(Project, :count)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    it "assigns the requested project to @project" do
      get :edit, params: { id: project.id }
      expect(assigns(:project)).to eq(project)
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      it "updates the requested project and redirects to show" do
        patch :update, params: { id: project.id, project: { title: 'Updated Title', status: :completed } }
        project.reload
        expect(project.title).to eq('Updated Title')
        expect(project.status).to eq('completed')
        expect(response).to redirect_to(project_path(project))
        expect(flash[:notice]).to eq('Project status was successfully updated.')
      end
    end

    context "with invalid params" do
      it "does not update the project and re-renders the edit template" do
        patch :update, params: { id: project.id, project: { title: '', status: :completed } }
        expect(project.title).to_not eq('')
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested project and redirects to projects path" do
      project_to_destroy = create(:project, user: user, status: :pending)
      expect {
        delete :destroy, params: { id: project_to_destroy.id }
      }.to change(Project, :count).by(-1)
      expect(response).to redirect_to(projects_path)
    end
  end
end
