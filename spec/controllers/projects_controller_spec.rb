require "spec_helper"


describe ProjectsController do
  let(:project) { create(:project) }

  describe "#index" do

    it "assigns projects instance var that includes project" do
      project
      get :index
      expect(assigns(:projects)).to include project  
    end
  end

  describe "#new" do
    # before { get: new }
    # specify { assigns(:project).should be }
    # it      { expect(response).to render_template(:new) }

    it "assigns a new project instance var" do
      get :new  
      expect(assigns(:project)).to be_instance_of(Project) # ..to be(true)
    end
  end

  describe "#create" do

    context "with valid params" do
      def valid_request
        post :create, project: {title: "some valid title", description: "valid description"}
      end

      it "creates a project record in the database" do
        expect { valid_request }.to change {Project.count}.by(1)
      end

      it "redirects to project show page" do
        valid_request
        expect(response).to redirect_to(Project.last)
      end

    end


    context "with invalid params" do
      def invalid_request
        post :create, project: {title: "", description: "valid description"}
      end

      it "doens't create a record in the database" do
        expect { invalid_request }.to_not change { Project.count }
      end

      it "renders new template" do
        invalid_request
        expect(response).to render_template(:new)
      end

    end
  end

  describe "#edit" do

    it "assigns an instance variable with project whose id is passed" do
      get :edit, id: project.id
      expect(assigns(:project)).to eq(project)
    end
  end

  describe "#show" do

    it "assigns an instance variable with project whose id is passed" do
      get :show, id: project.id
      expect(assigns(:project)).to eq(project)
    end
  end

  describe "#update" do

    context "with valid params" do
      def valid_request
        patch :update, id: project.id, project: {title: "Some new title"}
      end

      it "changes title to the new passed title" do
        valid_request
        project.reload
        expect(project.title).to eq("Some new title")
      end

      it "redirect to project show page" do
        valid_request
        expect(response).to redirect_to(project)
      end
    end

    context "with invalid params" do
      def invalid_request
        patch :update, id: project.id, project: {title: ""}
      end

      it "doesn't change the title" do
        # expect do
        #   invalid_request
        # end.to_not chage { project.reload.title }
        old_title = project.title
        invalid_request
        project.reload
        expect(project.title).to eq(old_title)
      end

      it "renders edit template" do
        invalid_request
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "#destroy" do

    it "remove the project from the database" do
      project
      expect { delete :destroy, id: project.id }.to change { Project.count }.by(-1)
    end

    it "redirect to project listing page" do
      delete :destroy, id: project.id
      expect(response).to redirect_to(projects_path)
    end
  end

end