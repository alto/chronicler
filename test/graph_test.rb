require File.expand_path(File.dirname(__FILE__) + '/helper')
require "app/models/chronicler/graph"

class GraphTest < ActiveSupport::TestCase
  
  def setup
    User.delete_all
    User.create(:created_at => 14.days.ago)
    User.create(:created_at => 13.days.ago)
    User.create(:created_at => 13.days.ago)
    User.create(:created_at =>  3.days.ago)
    User.create(:created_at =>  2.days.ago)
  end

  test "creating a graph" do
    graph = Chronicler::Graph.create([User])
    # puts graph.to_json
    assert_equal "User", graph[:elements][0][:text]
    assert_equal [1,3,3,3,3,3,3,3,3,3,3,4,5,5,5], graph[:elements][0][:values]
  end

end
