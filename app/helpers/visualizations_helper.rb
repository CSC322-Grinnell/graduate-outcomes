module VisualizationsHelper

    def empty_option
        [["---", ""]]
    end

    def get_form_variable_names
        [
            ["---", ""],
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
        empty_option +
        [
            ["Bar", "bar_chart"],
            ["Pie", "pie_chart"],
            ["Line", "line_chart"]
        ]
    end


    def get_form_variable_roles
        # Each element has format [<Display Name>, <Value>]
        empty_option +
        [
            ["---", ""],
            ["Group By", "group"],
            ["Independent", "independent"],
            ["Dependent", "dependent"]
        ]
    end


    def get_form_filter_types
        [
            ["---", ""],
            ["From..To", "from_to"],
            ["Equals", "equals"],
            ["Is Greater Than", "greater_than"],
            ["Is Greater Than Or Equal To", "greater_than_or_equal"],
            ["Is Less Than", "less_than"],
            ["Is Less Than Or Equal To", "less_than_or_equal"]

        ]
    end

    def get_form_summarize_methods
        [
            ["count"],
            ["sum"],
            ["maximum"],
            ["minimum"]
        ]
    end

    def get_chart(visualization)
        data = Student.all;
        chart_type = visualization.chart_type

        # Repeatedly apply each filter on the dataset
        visualization.filters.each do |filter|
            data = apply_filter(data, filter)
        end

        visualization.variables.each do |variable|
            data = set_variable(data, variable)
        end

        # Render visualization partial. This partial should have logic to determine which chart to graph
        render partial: "visualization", locals: {data: data, chart_type: chart_type}
    end


    # Applies a single filter on the dataset
    def apply_filter(data, filter_model)

        filter_hash = Hash.new
        variable_name = filter_model.variable_name;
        value1 = filter_model.value1
        value2 = filter_model.value2

        case filter
        when 'equals_to'
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


    def set_variable(data, variable_model)
        
        role = variable_model.role
        variable_name = variable_model.name
        calculation = variable_model.calculation

        case role
        when 'group'
            data = data.group(variable_name)
        else
            data
        end
    end


    def summarize(data, summarization_method)
        case summarization_method
        when 'sum'
            data = data.sum()
        when 'count'
            data = data.count()
        end
    end


end
