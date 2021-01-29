defmodule EmployeeManagementTest do
  use ExUnit.Case
  import TestSupport

  doctest EmployeeManagement

  @valid_no_dups fixture_csv("valid_no_dups.csv")

  describe "Removing duplicate employees" do
    test "by email" do
      output_file = EmployeeManagement.import_csv(fixture_csv("dups_email.csv"), :email)

      assert_matching_contents(@valid_no_dups.input_file, output_file)
      clean_up(output_file)
    end

    test "by phone" do
      output_file = EmployeeManagement.import_csv(fixture_csv("dups_phone.csv"), :phone)

      assert_matching_contents(@valid_no_dups.input_file, output_file)
      clean_up(output_file)
    end

    test "by email or phone" do
      output_file =
        EmployeeManagement.import_csv(fixture_csv("dups_email_or_phone.csv"), :email_or_phone)

      assert_matching_contents(@valid_no_dups.input_file, output_file)
      clean_up(output_file)
    end

    test "by email and ignoring a shared phone" do
      output_file =
        EmployeeManagement.import_csv(
          fixture_csv("dups_email_and_employees_sharing_phone.csv"),
          :email
        )

      assert_matching_contents(fixture_file("valid_employees_sharing_phone.csv"), output_file)
      clean_up(output_file)
    end
  end
end
