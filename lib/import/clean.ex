defmodule EmployeeManagement.Import.Clean do
  @moduledoc """
  Documentation for EmployeeManagement.Import.Clean.
  """

  alias EmployeeManagement.Import.CSV

  def dedup([headers | rows], :email) do
    [headers | dedup(rows, :email, headers: false)]
  end

  def dedup([headers | rows], :phone) do
    [headers | dedup(rows, :phone, headers: false)]
  end

  def dedup([headers | rows], :email_or_phone) do
    [
      headers
      | rows
        |> dedup(:email, headers: false)
        |> dedup(:phone, headers: false)
    ]
  end

  def dedup(rows, :email, headers: false) when is_list(rows) do
    rows |> Enum.dedup_by(fn [_, _, email, _] -> email end)
  end

  def dedup(rows, :phone, headers: false) when is_list(rows) do
    rows |> Enum.dedup_by(fn [_, _, _, phone] -> phone end)
  end
end
