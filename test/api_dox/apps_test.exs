defmodule ApiDox.AppsTest do
  use ApiDox.DataCase

  alias ApiDox.Apps

  describe "api" do
    alias ApiDox.Apps.Api

    @valid_attrs %{code: "some code", name: "some name"}
    @update_attrs %{code: "some updated code", name: "some updated name"}
    @invalid_attrs %{code: nil, name: nil}

    def api_fixture(attrs \\ %{}) do
      {:ok, api} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Apps.create_api()

      api
    end

    test "list_api/0 returns all api" do
      api = api_fixture()
      assert Apps.list_api() == [api]
    end

    test "get_api!/1 returns the api with given id" do
      api = api_fixture()
      assert Apps.get_api!(api.id) == api
    end

    test "create_api/1 with valid data creates a api" do
      assert {:ok, %Api{} = api} = Apps.create_api(@valid_attrs)
      assert api.code == "some code"
      assert api.name == "some name"
    end

    test "create_api/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Apps.create_api(@invalid_attrs)
    end

    test "update_api/2 with valid data updates the api" do
      api = api_fixture()
      assert {:ok, %Api{} = api} = Apps.update_api(api, @update_attrs)
      assert api.code == "some updated code"
      assert api.name == "some updated name"
    end

    test "update_api/2 with invalid data returns error changeset" do
      api = api_fixture()
      assert {:error, %Ecto.Changeset{}} = Apps.update_api(api, @invalid_attrs)
      assert api == Apps.get_api!(api.id)
    end

    test "delete_api/1 deletes the api" do
      api = api_fixture()
      assert {:ok, %Api{}} = Apps.delete_api(api)
      assert_raise Ecto.NoResultsError, fn -> Apps.get_api!(api.id) end
    end

    test "change_api/1 returns a api changeset" do
      api = api_fixture()
      assert %Ecto.Changeset{} = Apps.change_api(api)
    end
  end
end
