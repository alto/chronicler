module Chronicler
  class Line

    def self.retrieve_data_for(clazz, options={})
      start_date  = options[:start_date].to_date if options[:start_date]
      column      = options[:column] || "created_at"
      cumulate    = options[:cumulate]

      items = clazz.find_by_sql("SELECT DATE(#{column}) as date, COUNT(*) as countie FROM #{clazz.to_s.tableize} GROUP BY DATE(#{column}) ORDER BY DATE(#{column}) ASC")
      return [] if items.empty?
    
      start_date ||= items.first.date.to_date
      values = []
      current_value = 0
      items.each do |item|
        # puts "running #{start_date}...#{item.date.to_date}"
        (start_date...item.date.to_date).each do |date|
          values << (cumulate ? current_value : 0)
        end
        values << (cumulate ? current_value + item.countie.to_i : item.countie.to_i)
      
        start_date = item.date.to_date.next
        current_value += item.countie.to_i if cumulate
      end
      # puts "running #{start_date}..#{Date.today}"
      (start_date..Date.today).each do |date|
        values << (cumulate ? current_value : 0)
      end
      values
    end
    
  end
end
