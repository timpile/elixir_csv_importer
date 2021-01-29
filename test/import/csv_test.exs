defmodule CSVTest do
  use ExUnit.Case

  import TestSupport

  alias EmployeeManagement.Import.CSV

  doctest CSV

  describe "A new CSV" do
    test "with a valid file name" do
      assert CSV.new("new.csv") == %CSV{
               input_file: "new.csv",
               output_file: "output/new.csv"
             }
    end

    test "with a valid file name and path" do
      assert CSV.new("new.csv", ["path", "to", "file"]) == %CSV{
               input_file: "path/to/file/new.csv",
               output_file: "output/new.csv"
             }
    end

    test "returns an error when not a csv file" do
      assert CSV.new("new.txt") == {:error, "File must have a .csv extension."}
    end
  end

  describe "Reading a csv file" do
    test "has headers as the first row" do
      [headers | _] = CSV.read(fixture_file("valid_no_dups.csv"))

      assert headers == ["FirstName", "LastName", "Email", "Phone"]
    end

    test "returns correctly parsed rows" do
      [_ | rows] = CSV.read(fixture_file("valid_no_dups.csv"))

      assert rows == [
               ["Luke", "Skywalker", "luke.skywalker@example.com", "206-111-1111"],
               ["Leia", "Skywalker", "leia.skywalker@example.com", "206-222-2222"],
               ["Han", "Solo", "han.solo@example.com", "206-333-3333"]
             ]
    end

    test "with headers only" do
      assert CSV.read(fixture_file("headers_only.csv")) == [
               ["FirstName", "LastName", "Email", "Phone"]
             ]
    end

    test "with missing non-key values" do
      assert CSV.read(fixture_file("missing_non_key_values.csv")) == [
               ["FirstName", "LastName", "Email", "Phone"],
               ["Luke", "", "luke.skywalker@example.com", "206-111-1111"],
               ["Leia", "", "leia.skywalker@example.com", "206-222-2222"],
               ["Han", "", "han.solo@example.com", "206-333-3333"]
             ]
    end
  end

  describe "writing a csv file" do
    test "a new file is created with the correct content" do
      rows = [
        ["FirstName", "LastName", "Email", "Phone"],
        ["Luke", "Skywalker", "luke.skywalker@example.com", "206-111-1111"],
        ["Leia", "Skywalker", "leia.skywalker@example.com", "206-222-2222"],
        ["Han", "Solo", "han.solo@example.com", "206-333-3333"]
      ]

      output_file = "output/new_output_file.csv"

      CSV.write(rows, output_file)

      assert_matching_contents(fixture_file("valid_no_dups.csv"), output_file)
      clean_up(output_file)
    end
  end
end
