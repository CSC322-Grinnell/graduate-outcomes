require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  # Simple validity test
  # Each field should be present

  def setup
    @student = Student.new(class_year: "2018", student_id: "12345", major1: "BIO", major2: "CSC", gender: "M", fed_group: "white", intern: "TRUE", research: "FALSE", service: "TRUE", career_related: "moderately", job_field: "consulting", FDS_cat: "employ", gs_select: "TRUE", gs_level: "doctoral", gs_type: "science")
  end

  test "should be valid" do
    assert @student.valid?
  end

  test "class year should be present" do
    @student.class_year = " "
    assert_not @student.valid?
  end

  test "student id should be present" do
    @student.student_id = " "
    assert_not @student.valid?
  end

  test "major1 should be present" do
    @student.major1 = " "
    assert_not @student.valid?
  end

  test "major2 should be present" do
    @student.major2 = " "
    assert_not @student.valid?
  end

  test "gender should be present" do
    @student.gender = " "
    assert_not @student.valid?
  end

  test "fed_group should be present" do
    @student.fed_group = " "
    assert_not @student.valid?
  end

  test "intern should be present" do
    @student.intern = " "
    assert_not @student.valid?
  end

  test "research should be present" do
    @student.research = " "
    assert_not @student.valid?
  end

  test "service should be present" do
    @student.service = " "
    assert_not @student.valid?
  end

  test "career related should be present" do
    @student.career_related = " "
    assert_not @student.valid?
  end

  test "job field should be present" do
    @student.job_field = " "
    assert_not @student.valid?
  end

  test "first destination category should be present" do
    @student.FDS_cat = " "
    assert_not @student.valid?
  end

  test "Grad school boolean should be present" do
    @student.gs_select = " "
    assert_not @student.valid?
  end

  test "Grad school level should be present" do
    @student.gs_level = " "
    assert_not @student.valid?
  end

  test "Grad school type should be present" do
    @student.gs_type = " "
    assert_not @student.valid?
  end

  test "student ids should be unique" do
    duplicate_student = @student.dup
    @student.save
    assert_not duplicate_student.valid?
  end

end
