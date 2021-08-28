defmodule ApiDoxWeb.ApiLiveTest do
  use ApiDoxWeb.ConnCase

  import Phoenix.LiveViewTest

  alias ApiDox.Apps

  @create_attrs %{code: "some code", name: "some name"}
  @update_attrs %{code: "some updated code", name: "some updated name"}
  @invalid_attrs %{code: nil, name: nil}

  defp fixture(:api) do
    {:ok, api} = Apps.create_api(@create_attrs)
    api
  end

  defp create_api(_) do
    api = fixture(:api)
    %{api: api}
  end

  describe "Index" do
    setup [:create_api]

    test "lists all api", %{conn: conn, api: api} do
      {:ok, _index_live, html} = live(conn, Routes.api_index_path(conn, :index))

      assert html =~ "Listing Api"
      assert html =~ api.code
    end

    test "saves new api", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.api_index_path(conn, :index))

      assert index_live |> element("a", "New Api") |> render_click() =~
               "New Api"

      assert_patch(index_live, Routes.api_index_path(conn, :new))

      assert index_live
             |> form("#api-form", api: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#api-form", api: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.api_index_path(conn, :index))

      assert html =~ "Api created successfully"
      assert html =~ "some code"
    end

    test "updates api in listing", %{conn: conn, api: api} do
      {:ok, index_live, _html} = live(conn, Routes.api_index_path(conn, :index))

      assert index_live |> element("#api-#{api.id} a", "Edit") |> render_click() =~
               "Edit Api"

      assert_patch(index_live, Routes.api_index_path(conn, :edit, api))

      assert index_live
             |> form("#api-form", api: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#api-form", api: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.api_index_path(conn, :index))

      assert html =~ "Api updated successfully"
      assert html =~ "some updated code"
    end

    test "deletes api in listing", %{conn: conn, api: api} do
      {:ok, index_live, _html} = live(conn, Routes.api_index_path(conn, :index))

      assert index_live |> element("#api-#{api.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#api-#{api.id}")
    end
  end

  describe "Show" do
    setup [:create_api]

    test "displays api", %{conn: conn, api: api} do
      {:ok, _show_live, html} = live(conn, Routes.api_show_path(conn, :show, api))

      assert html =~ "Show Api"
      assert html =~ api.code
    end

    test "updates api within modal", %{conn: conn, api: api} do
      {:ok, show_live, _html} = live(conn, Routes.api_show_path(conn, :show, api))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Api"

      assert_patch(show_live, Routes.api_show_path(conn, :edit, api))

      assert show_live
             |> form("#api-form", api: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#api-form", api: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.api_show_path(conn, :show, api))

      assert html =~ "Api updated successfully"
      assert html =~ "some updated code"
    end
  end
end
