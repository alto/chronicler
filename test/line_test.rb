require File.expand_path(File.dirname(__FILE__) + '/helper')

class LineTest < ActiveSupport::TestCase
  
  def setup
    User.delete_all
    User.create(:created_at => 14.days.ago)
    User.create(:created_at => 13.days.ago)
    User.create(:created_at => 13.days.ago)
    User.create(:created_at =>  3.days.ago)
    User.create(:created_at =>  2.days.ago)
  end

  test "retrieving user data" do
    assert_equal [1,2,0,0,0,0,0,0,0,0,0,1,1,0,0], Line.retrieve_data_for(User, :start_date => 14.days.ago)
  end
  
  test "retrieving cumulated user data" do
    assert_equal [1,3,3,3,3,3,3,3,3,3,3,4,5,5,5], Line.retrieve_data_for(User, :start_date => 14.days.ago, :cumulate => true)
  end

end
