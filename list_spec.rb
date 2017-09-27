require "rspec"

require_relative "list"
require_relative "task"

describe List do
  
  let(:title) { "Chores" }
  let(:task)  { Task.new("Feeding pets") }
  let(:tasks) { [Task.new("Doing laundry"), Task.new("Vacuuming")] }
  let(:list)  { List.new(title, tasks) }

  describe "#initialize" do
  	it "takes a title for its first argument" do
  		expect(List.new("Today")).to be_a_kind_of(List)
  	end

  	it "requires at least one argument" do
  		expect { List.new }.to raise_error(ArgumentError)
  	end

  	it "takes two arguments" do
  		expect(List.new("Tomorrow", ["Doing laundry", "Vacuuming"])).to be_a_kind_of(List)
  	end
  end

  describe "#title" do
  	it "returns the correct title for the list" do
  		expect(list.title).to eq(title)
  	end
  end

  describe "#tasks" do
  	it "returns the correct tasks for the list" do
  		expect(list.tasks).to eq(tasks)
  	end
  end

  describe "#add_task" do
  	it "requires one argument" do
  		expect { list.add_task }.to raise_error(ArgumentError)
  	end

  	it "returns an array" do
  		expect(list.add_task(task)).to be_an_instance_of(Array)
  	end

  	it "add the correct task" do
  		array_size = list.tasks.count
  		list.add_task(task)
  		new_array_size = list.tasks.count
  		expect(new_array_size).to eq array_size + 1
  		expect(list.tasks[-1]).to eq task
  	end
  end

  describe "#complete_task" do
  	it "requires one argument" do
  		expect { list.complete_task }.to raise_error(ArgumentError)
  	end

  	it "changes the tasks[index] from incomplete to completed" do
  		expect(list.tasks[0]).not_to be_complete
  		expect(list.complete_task(0)).to eq(true)
  		expect(list.tasks[0]).to be_complete
  	end

    it "returns false for not existing task" do
      expect(list.complete_task(5)).to eq(false)
    end
  end

	describe "#delete_task" do
		it "requires one argument" do
  		expect { list.delete_task }.to raise_error(ArgumentError)
  	end

		it "delete the correct task" do
			task_to_be_deleted = tasks[0]
  		array_size = list.tasks.count
  		expect(list.delete_task(0)).to eq task_to_be_deleted
  		new_array_size = list.tasks.count
  		expect(new_array_size).to eq array_size - 1
  	end
  end

  describe "#completed_tasks" do
  	it "returns an array" do
  		expect(list.completed_tasks).to be_an_instance_of(Array)
  	end

  	it "returns only completed tasks" do
  		expect(list.completed_tasks.count).to eq 0
  		list.complete_task(0)
  		expect(list.completed_tasks.count).to eq 1
  	end
  end

  describe "#incomplete_tasks" do
  	it "returns an array" do
  		expect(list.incomplete_tasks).to be_an_instance_of(Array)
  	end

  	it "returns only incomplete tasks" do
  		expect(list.incomplete_tasks.count).to eq 2
  	end
  end  
end