module VisualizationsHelper

    def get_form_variable_names
        [
            ["class_year", "class_year"],
            ["major1", "major1"],
            ["major2", "major2"],
            ["gender", "gender"],
            ["fed_group", "fed_group"],
            ["intern", "intern"],
            ["research", "research"],
            ["service", "service"],
            ["career_related", "career_related"],
            ["job_field", "job_field"]
        ]
        # Student.column_names.reject {|c| ["id", "student_id", "updated_at", "created_at"].include? c}
    end


    def get_form_chart_types
        # Each element has format [<Display Name>, <Value>]
        [
            ["Bar", "bar_chart"],
            ["Column", "column_chart"],
            ["Pie", "pie_chart"],
            ["Line", "line_chart"]
        ]
    end


    def get_form_variable_roles
        # Each element has format [<Display Name>, <Value>]
        [
            ["Group By", "group"],
            ["Independent", "independent"],
            ["Dependent", "dependent"]
        ]
    end


    def get_form_filter_types
        [
            ["From..To", "from_to"],
            ["Equals", "equals"],
            ["Is Greater Than", "greater_than"],
            ["Is Greater Than Or Equal To", "greater_than_or_equal"],
            ["Is Less Than", "less_than"],
            ["Is Less Than Or Equal To", "less_than_or_equal"]

        ]
    end

    # not being used yet. In future allow user to select kind of summarization. 
    def get_form_summarize_methods
        [
            ["count"],
            ["sum"],
            ["maximum"],
            ["minimum"]
        ]
    end

    def get_chart_info(visualization_id)
        data = Student.all;
        visualization = Visualization.find(visualization_id)
        chart_type = visualization.chart_type

        # Repeatedly apply each filter on the dataset
        visualization.filters.each_with_index do |filter, index|
            data = apply_filter(data, filter)
            puts ">> Applied filter #{index + 1}: #{filter.inspect}"
        end

        # Reverse since for some reason it groups in the wrong order without reversing.
        visualization.variables.reverse.each_with_index do |variable, index|
            data = set_variable(data, variable, chart_type)
            puts ">> Set variable #{index + 1} : #{variable.inspect}"
        end

        # Final summarization before rendering. Make this more dynamic in the future to support max, min, etc.
        data = summarize(data, 'count')

        chart_info = Hash.new
        chart_info[:data] = data
        chart_info[:chart_type] = chart_type
        chart_info[:options] = get_chart_options(visualization_id)
        # Render visualization partial. This partial should have logic to determine which chart to graph
        return chart_info
    end



    # Applies a single filter on the dataset
    def apply_filter(data, filter_model)
        filter_type = filter_model.filter_type
        variable_name = filter_model.variable_name;
        value1 = filter_model.value1
        value2 = filter_model.value2

        case filter_type
            when 'equals_to'
                filter_hash = Hash.new
                filter_hash[variable_name] = value1
                data = data.where(filter_hash)

            when 'greater_than'
                data = data.where("#{variable_name} > ?", variable_name, value1)

            when 'greater_than_or_equal'
                data = data.where("#{variable_name} >= ?", value1)

            when 'less_than'
                data = data.where("#{variable_name} > ?", value1)

            when 'less_than_or_equal'
                data = data.where("#{variable_name} >= ?", value1)

            when 'from_to'
                data = data.where("#{variable_name} >= ? AND #{variable_name} <= ?", value1, value2)

            else
                data
        end
    end


    def set_variable(data, variable_model, chart_type)
        
        role = variable_model.role
        variable_name = variable_model.name
        #TO DO: add more variable types (Independent, Dependent)
        if variable_name.length == 0
            return data
        end

        case role
            when 'group'
                data = data.group(variable_name)
            when 'independent'
                data = data.group(variable_name)
            when 'dependent'
                data = data.group(variable_name)
            else
                data.count
        end
    end

    # Not being used yet. 
    def summarize(data, summarization_method, variable=nil)
        case summarization_method
            when 'sum'
                data = data.sum(variable)
            when 'max'
                data = data.maximum(variable)
            when 'count'
                data = data.count(variable)
        end
    end

    # should return options such as the axis titles and so forth
    def get_chart_options(visualization_id)
        visualization = Visualization.find(visualization_id)
        options = Hash.new

        options[:title] = visualization.chart_title
        options[:download] = true
        options[:xtitle] = visualization.x_axis_title
        options[:ytitle] = visualization.y_axis_title
        options[:donut] = true;

        return options

    end


    def get_form_filter_values
        options = []

        Student.column_names
            .reject{|c| ["id", "student_id", "updated_at", "created_at"].include? c}
            .each do |name|  
                possible_values = Student.distinct.pluck(name)
                possible_values.each do |value| 
                    options = options + [["#{name}:#{value}", "#{value}"]]
                end
            end
        return options
    end
    
    def get_form_filter_values_2(name)
        options = Student.distinct.pluck("major_1")
        return options
    end

end
