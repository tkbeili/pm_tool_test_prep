require "spec_helper"


describe Task do
  let!(:completed_task) { create(:task, completed: true)}
  let!(:pending_task)   { create(:task, completed: false)}

  describe "#completed" do
    subject { Task.completed }

    it { should     include(completed_task) }
    it { should_not include(pending_task) }

  end

  describe "#pending" do
    subject { Task.pending }

    it { should     include(pending_task)   }
    it { should_not include(completed_task) }

  end


end