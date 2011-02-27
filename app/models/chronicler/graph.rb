module Chronicler
  class Graph
    
    COLORS = ["#FF0000","#00FF00","#0000FF"]
  
    def self.create(clazzes)
      output = {
        :y_axis => {:steps => 5, :max => 20, :min => 0},
        :title => {:text => "9flats"},
        :elements => []
      }

      clazzes.each_with_index do |clazz, i|
        values = Line.retrieve_data_for(clazz, :cumulate => true)
        output[:elements] << {
          :text => clazz.to_s,
          :type => "line",
          :font_size => 10,
          :colour => COLORS[i], # TODO support more than 3 colors [thorsten, 2011-02-27]
          :values => values
        }
        output[:y_axis][:max] = (output[:y_axis][:max] < values.max ? values.max : output[:y_axis][:max])
      end
      output
    end

  end
end
