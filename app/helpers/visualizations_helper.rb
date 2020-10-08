module VisualizationsHelper
    def get_form_variable_names
        Student.column_names.reject {|c| ["id", "student_id", "updated_at", "created_at"].include? c}
    end


    def get_form_chart_types
        # Each element has format [<Display Name>, <Value>]
        [
            ["Bar", "bar_chart"],
            ["Pie", "pie_chart"],
            ["Line", "line_chart"]
        ]
    end


    def get_form_variable_roles
        # Each element has format [<Display Name>, <Value>]
        [
            ["Group By", "group"]
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

end
