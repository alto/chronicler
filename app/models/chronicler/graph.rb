module Chronicler
  class Graph
  
    def self.create(clazzes)
      output = {
        :y_axis => {:steps => 5, :max => 20, :min => 0},
        :title => {:text => "9flats"},
        :elements => []
      }

      clazzes.each do |clazz|
        values = Line.retrieve_data_for(clazz, :cumulate => true)
        output[:elements] << {
          :text => clazz.to_s,
          :type => "line",
          :font_size => 10,
          :colour => ["#FF0000","#00FF00","#0000FF"].shuffle.first,
          :values => values
        }
        output[:y_axis][:max] = (output[:y_axis][:max] < values.max ? values.max : output[:y_axis][:max])
      end
      output
    end

  end
end
