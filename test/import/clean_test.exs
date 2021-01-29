defmodule CleanTest do
  use ExUnit.Case

  alias EmployeeManagement.Import.Clean

  doctest Clean

  @no_dups [
    ["FirstName", "LastName", "Email", "Phone"],
    ["Luke", "Skywalker", "luke.skywalker@example.com", "206-111-1111"],
    ["Leia", "Skywalker", "leia.skywalker@example.com", "206-222-2222"],
    ["Han", "Solo", "han.solo@example.com", "206-333-3333"]
  ]

  @dups_email [
    ["FirstName", "LastName", "Email", "Phone"],
    ["Luke", "Skywalker", "luke.skywalker@example.com", "206-111-1111"],
    ["Leia", "Skywalker", "leia.skywalker@example.com", "206-222-2222"],
    ["Han", "Solo", "han.solo@example.com", "206-333-3333"],
    ["Han", "Solo", "han.solo@example.com", "206-444-4444"]
  ]

  @dups_phone [
    ["FirstName", "LastName", "Email", "Phone"],
    ["Luke", "Skywalker", "luke.skywalker@example.com", "206-111-1111"],
    ["Leia", "Skywalker", "leia.skywalker@example.com", "206-222-2222"],
    ["Leia", "Skywalker", "princess.leia@example.com", "206-222-2222"],
    ["Han", "Solo", "han.solo@example.com", "206-333-3333"]
  ]

  @dups_email_or_phone [
    ["FirstName", "LastName", "Email", "Phone"],
    ["Luke", "Skywalker", "luke.skywalker@example.com", "206-111-1111"],
    ["Leia", "Skywalker", "leia.skywalker@example.com", "206-222-2222"],
    ["Leia", "Skywalker", "princess.leia@example.com", "206-222-2222"],
    ["Han", "Solo", "han.solo@example.com", "206-333-3333"],
    ["Han", "Solo", "han.solo@example.com", "206-444-4444"]
  ]

  describe "Data without duplicates remains the same" do
    test "by email" do
      assert @no_dups == Clean.dedup(@no_dups, :email)
    end

    test "by phone" do
      assert @no_dups == Clean.dedup(@no_dups, :phone)
    end

    test "by email or phone" do
      assert @no_dups == Clean.dedup(@no_dups, :email_or_phone)
    end
  end

  describe "Removing duplicates" do
    test "by email" do
      assert @no_dups == Clean.dedup(@dups_email, :email)
    end

    test "by phone" do
      assert @no_dups == Clean.dedup(@dups_phone, :phone)
    end

    test "by email or phone" do
      assert @no_dups == Clean.dedup(@dups_email_or_phone, :email_or_phone)
    end
  end
end
