<<<<<<< HEAD
module VisualizationsHelper

    def get_form_variable_names
        [
          # These represent the display names and the actual values
            ["class_year", "class_year"],
            ["major1", "major1"],
            ["major2", "major2"],
            ["gender", "gender"],
            ["fed_group", "fed_group"],
            ["intern", "intern"],
            ["research", "research"],
            ["service", "service"],
            ["career_related", "career_related"],
            ["job_field", "job_field"],
            ["FDS_cat", "FDS_cat"],
            ["gs_select", "gs_select"],
            ["gs_level", "gs_level"],
            ["gs_type", "gs_type"]
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
            ["Not Equal To", "not_equals"],
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
            data = group_by_variable(data, variable)
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
            when 'equals'
                filter_hash = Hash.new
                filter_hash[variable_name] = value1
                data = data.where(filter_hash)

            when 'not_equals'
                filter_hash = Hash.new
                filter_hash[variable_name] = value1
                data = data.where.not(filter_hash)

            when 'greater_than'
                data = data.where("#{variable_name} > ?", value1)

            when 'greater_than_or_equal'
                data = data.where("#{variable_name} >= ?", value1)

            when 'less_than'
                data = data.where("#{variable_name} < ?", value1)

            when 'less_than_or_equal'
                data = data.where("#{variable_name} <= ?", value1)

            when 'from_to'
                data = data.where("#{variable_name} >= ? AND #{variable_name} <= ?", value1, value2)

            else
                data
        end
    end

    # Group rows in table 'data' that have the same value for column 'variable_model'
    # prereq: column 'variable_model' must appear in table 'data'
    # returns: new table with grouped rows
    def group_by_variable(data_table, var) 
        # TODO: in future, group the table differently based on variable role
        if (data_table.is_a?(ActiveRecord::Relation) && var.is_a?(Variable) && data_table.has_attribute?(var.name))
            return data_table.group(var.name)
        else
            raise "group_by_variable was improperly used."
        end
    end
    
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

    def shorten_title(title)
        if title.length > 45
            return title[0..45] + "..."
        else return title
        end
    end
end
=======
module VisualizationsHelper

    def get_form_variable_names
        [
          # These represent the display names and the actual values in form [<Display Name>, <Value>]
            ["Class Year", "class_year"],
            ["Major 1", "major1"],
            ["Major 2", "major2"],
            ["Gender", "gender"],
            ["Federal Identity Group", "fed_group"], # is there a better way to phrase "federally recognized race?"
            ["Did Internship", "intern"],
            ["Did Research", "research"],
            ["Did Service Learning", "service"],
            ["Career Related to Interest", "career_related"], 
            ["Job Field", "job_field"],
            ["Outcome Category", "FDS_cat"],
            ["Graduate School", "gs_select"],
            ["Grad School Level", "gs_level"],
            ["Grad School Type", "gs_type"]
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
            ["Not Equal To", "not_equals"],
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
            data = group_by_variable(data, variable)
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
            when 'equals'
                filter_hash = Hash.new
                filter_hash[variable_name] = value1
                data = data.where(filter_hash)

            when 'not_equals'
                filter_hash = Hash.new
                filter_hash[variable_name] = value1
                data = data.where.not(filter_hash)

            when 'greater_than'
                data = data.where("#{variable_name} > ?", value1)

            when 'greater_than_or_equal'
                data = data.where("#{variable_name} >= ?", value1)

            when 'less_than'
                data = data.where("#{variable_name} < ?", value1)

            when 'less_than_or_equal'
                data = data.where("#{variable_name} <= ?", value1)

            when 'from_to'
                data = data.where("#{variable_name} >= ? AND #{variable_name} <= ?", value1, value2)

            else
                data
        end
    end

    # Group rows in table 'data' that have the same value for column 'variable_model'
    # prereq: column 'variable_model' must appear in table 'data'
    # returns: new table with grouped rows
    def group_by_variable(data_table, var) 
        # TODO: in future, group the table differently based on variable role
        if (data_table.is_a?(ActiveRecord::Relation) && var.is_a?(Variable) && data_table.has_attribute?(var.name))
            return data_table.group(var.name)
        else
            raise "group_by_variable was improperly used."
        end
    end
    
    # gives summary of data in given method (total, maximum, or number of points)
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


    # gets values to give as options when filtering values
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

    # changes title to first 45 characters if longer than that
    def shorten_title(title)
        if title.length > 45
            return title[0..45] + "..."
        else return title
        end
    end
end
>>>>>>> master
