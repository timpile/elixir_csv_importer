defmodule EmployeeManagement do
  @moduledoc """
  Documentation for EmployeeManagement.
  """

  @doc """
  ## Examples

  iex> alias EmployeeManagement.Import.CSV
  iex> csv = CSV.new("dups_email.csv", ["test", "fixtures"])
  iex> EmployeeManagement.import_csv(csv, :email)
  "output/dups_email.csv"
  iex> EmployeeManagement.import_csv(csv, :phone)
  "output/dups_email.csv"
  iex> EmployeeManagement.import_csv(csv, :email_or_phone)
  "output/dups_email.csv"
  """

  alias EmployeeManagement.Import.{Clean, CSV}

  def import_csv(%CSV{} = csv, duplicate_detection_strategy) do
    CSV.read(csv.input_file)
    |> Clean.dedup(duplicate_detection_strategy)
    |> CSV.write(csv.output_file)

    csv.output_file
  end
end
