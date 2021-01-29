defmodule EmployeeManagement.Import.CSV do
  @moduledoc """
  Documentation for EmployeeManagement.Import.CSV.
  """

  @output_dir "output"

  defstruct [:input_file, :output_file]

  alias EmployeeManagement.Import.CSV

  @doc """
  ## Example
  iex> alias EmployeeManagement.Import.CSV
  iex> CSV.new("dups_email.csv", ["test", "fixtures"])
  %CSV{input_file: "test/fixtures/dups_email.csv", output_file: "output/dups_email.csv"}
  iex> CSV.new("bad.txt")
  {:error, "File must have a .csv extension."}
  """

  def new(file_name, path \\ [])

  def new(file_name, path) do
    file_name
    |> validate()
    |> build(path, output_file(file_name))
  end

  def new(file_name, path, :output_timestamp) do
    file_name
    |> validate()
    |> build(path, output_file(file_name, :output_timestamp))
  end

  def read(input_file) do
    File.stream!(input_file)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.split(&1, ","))
  end

  def write(rows, output_file) do
    output_file
    |> File.write!(comma_delimited(rows) |> Enum.join("\n"))
  end

  defp validate(file_name) do
    if not String.ends_with?(file_name, ".csv") do
      {:error, "File must have a .csv extension."}
    else
      file_name
    end
  end

  defp build({:error, _msg} = validation_error, _, _), do: validation_error

  defp build(file_name, path, output_file) when is_list(path) do
    %CSV{
      input_file: (path ++ [file_name]) |> Enum.join("/"),
      output_file: output_file
    }
  end

  defp comma_delimited([]), do: []

  defp comma_delimited([row | rows]) do
    [Enum.join(row, ",") | comma_delimited(rows)]
  end

  defp output_file(file_name), do: "#{@output_dir}/#{file_name}"

  defp output_file(file_name, :output_timestamp) do
    file_name
    |> String.replace(".csv", "#{DateTime.utc_now()}.csv")
    |> output_file()
  end
end
