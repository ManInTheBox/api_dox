defmodule ApiDox.ServicesTest do
  use ApiDox.DataCase

  alias ApiDox.Services

  describe "service" do
    alias ApiDox.Services.Service

    @valid_attrs %{
      api_spec: "some api_spec",
      code: "some code",
      name: "some name",
      repository_url: "some repository_url"
    }
    @update_attrs %{
      api_spec: "some updated api_spec",
      code: "some updated code",
      name: "some updated name",
      repository_url: "some updated repository_url"
    }
    @invalid_attrs %{api_spec: nil, code: nil, name: nil, repository_url: nil}

    def service_fixture(attrs \\ %{}) do
      {:ok, service} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Services.create_service()

      service
    end

    test "list_service/0 returns all service" do
      service = service_fixture()
      assert Services.list_service() == [service]
    end

    test "get_service!/1 returns the service with given id" do
      service = service_fixture()
      assert Services.get_service!(service.id) == service
    end

    test "create_service/1 with valid data creates a service" do
      assert {:ok, %Service{} = service} = Services.create_service(@valid_attrs)
      assert service.api_spec == "some api_spec"
      assert service.code == "some code"
      assert service.name == "some name"
      assert service.repository_url == "some repository_url"
    end

    test "create_service/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Services.create_service(@invalid_attrs)
    end

    test "update_service/2 with valid data updates the service" do
      service = service_fixture()
      assert {:ok, %Service{} = service} = Services.update_service(service, @update_attrs)
      assert service.api_spec == "some updated api_spec"
      assert service.code == "some updated code"
      assert service.name == "some updated name"
      assert service.repository_url == "some updated repository_url"
    end

    test "update_service/2 with invalid data returns error changeset" do
      service = service_fixture()
      assert {:error, %Ecto.Changeset{}} = Services.update_service(service, @invalid_attrs)
      assert service == Services.get_service!(service.id)
    end

    test "delete_service/1 deletes the service" do
      service = service_fixture()
      assert {:ok, %Service{}} = Services.delete_service(service)
      assert_raise Ecto.NoResultsError, fn -> Services.get_service!(service.id) end
    end

    test "change_service/1 returns a service changeset" do
      service = service_fixture()
      assert %Ecto.Changeset{} = Services.change_service(service)
    end
  end
end
