module UploadsHelper

    def get_unique_class_years
        years_with_created_at = []
        years = Student.distinct.pluck(:class_year)
        years.each do |y|
            hash = Hash.new
            hash[:class_year] = y
            hash[:created_at] = Student.order(created_at: :desc).find_by(class_year: y).created_at
            years_with_created_at = years_with_created_at + [hash]
        end

        puts years_with_created_at
        return years_with_created_at
    end

end
