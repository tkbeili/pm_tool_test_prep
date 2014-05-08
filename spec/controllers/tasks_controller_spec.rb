require "spec_helper"


describe TasksController do
  let(:project) { create(:project) }
  
  describe "#create" do

    context "with valid request" do
      def valid_request
        post :create, project_id: project.id, task: {title: "some valid title"}
      end

      it "creates a task for the project" do
        expect { valid_request }.to change { project.tasks.count }.by(1)
      end

      it "assigns the task to the project" do
        valid_request
        expect(Task.last.project).to eq(project)
      end

      it "render success json message" do
        valid_request
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["status"]).to eq "success"
      end

      it "sends back the title" do
        valid_request
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["title"]).to eq Task.last.title
      end

      it "includes url for updating task" do
        valid_request
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["url"]).to eq(project_task_path(project, Task.last))
      end

    end

    context "with invalid request" do
      def invalid_request
        post :create, project_id: project.id, task: {title: ""}
      end

      it "doesn't create a task in the database" do
        expect { invalid_request }.to_not change { Task.count }
      end

      it "renders failure status message" do
        invalid_request
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["status"]).to eq("failure")
      end

      it "sends error message" do
        invalid_request
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["errors"]).to be
      end
    end

  end


  describe "#update" do
    let(:task) { create(:task, project: project, completed: false) }

    it "updates the changed value in the database" do
      patch :update, project_id: project.id, id: task.id, task: {completed: true}
      expect(task.reload.completed).to eq(true)
    end

  end


end