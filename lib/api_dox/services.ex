defmodule ApiDox.Services do
  @moduledoc """
  The Services context.
  """

  import Ecto.Query, warn: false
  alias ApiDox.Repo

  alias ApiDox.Services.Service

  @doc """
  Returns the list of service.

  ## Examples

      iex> list_service()
      [%Service{}, ...]

  """
  def list_service do
    Repo.all(Service)
  end

  @doc """
  Gets a single service.

  Raises `Ecto.NoResultsError` if the Service does not exist.

  ## Examples

      iex> get_service!(123)
      %Service{}

      iex> get_service!(456)
      ** (Ecto.NoResultsError)

  """
  def get_service!(id) do
    Repo.get!(Service, id)
    |> parse_open_api_spec()
  end

  def get_by_code!(code) do
    Repo.get_by!(Service, code: code)
    |> parse_open_api_spec()
  end

  @doc """
  Creates a service.

  ## Examples

      iex> create_service(%{field: value})
      {:ok, %Service{}}

      iex> create_service(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_service(attrs \\ %{}) do
    %Service{}
    |> Service.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a service.

  ## Examples

      iex> update_service(service, %{field: new_value})
      {:ok, %Service{}}

      iex> update_service(service, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_service(%Service{} = service, attrs) do
    service
    |> Service.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a service.

  ## Examples

      iex> delete_service(service)
      {:ok, %Service{}}

      iex> delete_service(service)
      {:error, %Ecto.Changeset{}}

  """
  def delete_service(%Service{} = service) do
    Repo.delete(service)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking service changes.

  ## Examples

      iex> change_service(service)
      %Ecto.Changeset{data: %Service{}}

  """
  def change_service(%Service{} = service, attrs \\ %{}) do
    Service.changeset(service, attrs)
  end

  defp parse_open_api_spec(service) do
    service
    # |> Map.update!(:api_spec, fn spec ->
    #   spec
    #   |> YamlElixir.read_from_string!()
    #   |> OpenApiSpex.OpenApi.Decode.decode()
    # end)
  end
end
