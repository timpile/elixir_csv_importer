# Elixir CSV Importer
> For Employee Management Data

## Usage

Clone the repo.
```zsh
$ git clone https://github.com/timpile/elixir_csv_importer.git
$ cd elixir_csv_importer/
```

Run tests.
```zsh
$ mix test
```

Start an interactive console.
```zsh
$ iex -S mix
```

Your CSV file should look something like this, with the first row containing headers.
```csv
FirstName,LastName,Email,Phone
Luke,Skywalker,luke.skywalker@example.com,206-111-1111
Leia,Skywalker,leia.skywalker@example.com,206-222-2222
Han,Solo,han.solo@example.com,206-333-3333
```

Import and deduplicate a CSV file.
```elixir
iex> import_file = "employee_data.csv"
iex> import_path = ["test", "fixtures"]
iex> alias EmployeeManagement.Import.CSV
iex> csv = CSV.new(import_file, import_path)
iex> EmployeeManagement.import_csv(csv, :email)
"output/employee_data.csv"
iex> EmployeeManagement.import_csv(csv, :phone)
"output/employee_data.csv"
iex> EmployeeManagement.import_csv(csv, :email_or_phone)
"output/employee_data.csv"
```
