module VisualizationsHelper
    def empty_option
        [["--", ""]]
    end

    def get_form_variable_names
        empty_option +
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
            ["Group By", "group"],
            ["Independent", "independent"],
            ["Dependent", "dependent"]
        ]
    end


    def get_form_filter_types
        empty_option +
        [
            ["From..To", "from_to"],
            ["Equals", "equals"],
            ["Is Greater Than", "greater_than"],
            ["Is Greater Than Or Equal To", "greater_than_or_equal"],
            ["Is Less Than", "less_than"],
            ["Is Less Than Or Equal To", "less_than_or_equal"]

        ]
    end

    def get_form_filter_values
        options = empty_option

        Student.column_names
            .reject{|c| ["id", "student_id", "updated_at", "created_at"].include? c}
            .each do |name|  
                possible_values = Student.distinct.pluck(name)
                puts "Possible values #{possible_values}"
                possible_values.each do |value| 
                    options = options + [["#{name}:#{value}", "#{value}"]]
                end
            end

        puts "All options #{options}"
        return options
    end

end
