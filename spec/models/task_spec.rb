require 'spec_helper'

describe Task do

  context "new task" do
    its(:duration) { should == 0 }
    its(:early_end) { should == subject.early_start}
    it { should be_on_critical_path }
  end

  context "single" do
    subject { FactoryGirl.build :task, duration: 5, predecessors: [] }
    its(:duration) { should == 5 }
    its(:early_start) { should == 0 }
    its(:early_end) { should == 5 }
    its(:late_start) { should == 0 }
    its(:late_end) { should == 5 }
    it { should be_on_critical_path }
  end

  #             |-> book_hotel----|
  #  find_date -|-> plan_transfer-|-> info_meeting-|
  #             |-> lookup_city --|-> day_planning-|-> get_permit -> travel
  context "in chain" do
    let!(:find_date)     { FactoryGirl.create :task,  duration: 1,  predecessors: [] }
    let!(:book_hotel)    { FactoryGirl.create :task,  duration: 25, predecessors: [find_date] }
    let!(:plan_transfer) { FactoryGirl.create :task,  duration: 15, predecessors: [find_date] }
    let!(:lookup_city)   { FactoryGirl.create :task,  duration: 20, predecessors: [find_date] }
    let!(:day_planning)  { FactoryGirl.create :task,  duration: 10, predecessors: [lookup_city] }
    let!(:info_meeting)  { FactoryGirl.create :task,  duration: 1,  predecessors: [book_hotel, plan_transfer, lookup_city] }
    let!(:get_permit)    { FactoryGirl.create :task,  duration: 30, predecessors: [day_planning, info_meeting] }
    let!(:travel)        { FactoryGirl.create :task,  duration: 5,  predecessors: [get_permit] }

    it "is doubly connected" do
      travel.predecessors.should == [ get_permit ]
      get_permit.successors.should == [ travel ]
    end

    context "with single predecessors" do
      it("starts when previous task ends") do
        book_hotel.early_start.should == find_date.early_end
      end
    end

    context "with multiple predecessors" do
      it "early_start is after the last predecessor's early_end" do
        info_meeting.early_start.should == book_hotel.early_end
      end
    end

    context "with buffers" do
      subject { info_meeting }
      its(:free_buffer) { should == 4 }
      its(:total_buffer) { should == 4 }
      its(:early_start) { should == 26 }
      its(:early_end) { should == 27 }
      its(:late_start) { should == 30 }
      its(:late_end) { should == 31 }
    end

    context "end task" do
      subject { travel }

      its(:early_end) { should == 66 }
      its(:early_start) { should == 61 }
      its(:late_end) { should == subject.early_end }
      its(:late_start) { should == subject.early_start }
    end

    context "on critical path" do
      subject { travel }
      it { should be_on_critical_path }
      its(:total_buffer) { should == 0 }
      its(:free_buffer) { should == 0 }
    end

    it "are on correct critical path" do
      find_date.should be_on_critical_path
      lookup_city.should be_on_critical_path
      day_planning.should be_on_critical_path
      get_permit.should be_on_critical_path
      travel.should be_on_critical_path
    end

    it "are not on correct critical path" do
      book_hotel.should_not be_on_critical_path
      plan_transfer.should_not be_on_critical_path
      info_meeting.should_not be_on_critical_path
    end

    context "total buffer and free buffer differ" do
      subject { plan_transfer }
      its(:free_buffer) { should == 10 }
      its(:total_buffer) { should == 14 }
    end
  end
end
