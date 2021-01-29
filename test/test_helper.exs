ExUnit.start()

defmodule TestSupport do
  use ExUnit.Case

  alias EmployeeManagement.Import.CSV

  def fixture_csv(file_name) do
    CSV.new(file_name, ["test", "fixtures"], :output_timestamp)
  end

  def fixture_file(file_name) do
    fixture_csv(file_name).input_file
  end

  def assert_matching_contents(input_file, output_file) do
    assert File.exists?(output_file)
    assert File.read!(input_file) == File.read!(output_file)
  end

  def clean_up(file_path), do: File.rm!(file_path)
end
