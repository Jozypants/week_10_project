require "spec_helper"

describe Volunteer do

  before(:each) do
     @project = Project.new({:title => 'Teaching Kids to Code', :id => nil, })
    @project.save()
  end


  describe('#name')do
    it('returns the name of the volunteer') do
      test_volunteer = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      expect(test_volunteer.name).to eq 'Jane'
    end
  end

  describe('#project_id') do
    it('returns the project_id of the volunteer') do
      test_volunteer = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      expect(test_volunteer.project_id).to eq 1
    end
  end

  describe('#==') do
    it('checks for equality based on the name of a volunteer') do
      volunteer1 = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      volunteer2 = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      expect(volunteer1 == volunteer2).to eq true
    end
  end

  context('.all') do
    it('is empty to start') do
      expect(Volunteer.all).to eq []
    end

    it('returns all volunteers') do
      volunteer1 = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      volunteer1.save
      volunteer2 = Volunteer.new({:name => 'Joe', :project_id => 1, :id => nil})
      volunteer2.save
      expect(Volunteer.all).to eq [volunteer1, volunteer2]
    end
  end

  describe('#save') do
    it('adds a volunteer to the database') do
      volunteer1 = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      volunteer1.save
      expect(Volunteer.all).to eq [volunteer1]
    end
  end

  describe('.find') do
    it('returns a volunteer by id') do
      volunteer1 = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      volunteer1.save
      volunteer2 = Volunteer.new({:name => 'Joe', :project_id => 1, :id => nil})
      volunteer2.save
      expect(Volunteer.find(volunteer1.id)).to eq volunteer1
    end
  end

  describe('#update') do
    it("updates an volunteer by id") do
      volunteer1 = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      volunteer1.save
      volunteer1.update("Jasmine", 1)
      expect(volunteer1.name).to(eq("Jasmine"))
    end
  end

  context('#delete') do
    it('allows a user to delete a project') do
      volunteer = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      volunteer.save
      volunteer.delete
      expect(Volunteer.all).to eq []
    end
  end

    describe('.find_by_project') do
    it("finds volunteers for a project") do
      project2 = Project.new({:title => 'Teaching Ruby to Kids', :id => nil})
      project2.save
      volunteer1 = Volunteer.new({:name => 'Jane', :project_id => project2.id, :id => nil})
      volunteer1.save
      volunteer2 = Volunteer.new({:name => 'Joe', :project_id => @project.id , :id => nil})
      volunteer2.save
      expect(Volunteer.find_by_project(project2.id)).to(eq([volunteer1]))
    end
  end

  describe('#project') do
    it("finds the project a volunteer belongs to") do
      volunteer2 = Volunteer.new({:name => 'Joe', :project_id => @project.id , :id => nil})
      volunteer2.save
      expect(volunteer2.project()).to(eq(@project))
    end
  end

end
