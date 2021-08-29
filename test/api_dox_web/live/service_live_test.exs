defmodule ApiDoxWeb.ServiceLiveTest do
  use ApiDoxWeb.ConnCase

  import Phoenix.LiveViewTest

  alias ApiDox.Services

  @create_attrs %{
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

  defp fixture(:service) do
    {:ok, service} = Services.create_service(@create_attrs)
    service
  end

  defp create_service(_) do
    service = fixture(:service)
    %{service: service}
  end

  describe "Index" do
    setup [:create_service]

    test "lists all service", %{conn: conn, service: service} do
      {:ok, _index_live, html} = live(conn, Routes.service_index_path(conn, :index))

      assert html =~ "Listing Service"
      assert html =~ service.api_spec
    end

    test "saves new service", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.service_index_path(conn, :index))

      assert index_live |> element("a", "New Service") |> render_click() =~
               "New Service"

      assert_patch(index_live, Routes.service_index_path(conn, :new))

      assert index_live
             |> form("#service-form", service: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#service-form", service: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.service_index_path(conn, :index))

      assert html =~ "Service created successfully"
      assert html =~ "some api_spec"
    end

    test "updates service in listing", %{conn: conn, service: service} do
      {:ok, index_live, _html} = live(conn, Routes.service_index_path(conn, :index))

      assert index_live |> element("#service-#{service.id} a", "Edit") |> render_click() =~
               "Edit Service"

      assert_patch(index_live, Routes.service_index_path(conn, :edit, service))

      assert index_live
             |> form("#service-form", service: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#service-form", service: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.service_index_path(conn, :index))

      assert html =~ "Service updated successfully"
      assert html =~ "some updated api_spec"
    end

    test "deletes service in listing", %{conn: conn, service: service} do
      {:ok, index_live, _html} = live(conn, Routes.service_index_path(conn, :index))

      assert index_live |> element("#service-#{service.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#service-#{service.id}")
    end
  end

  describe "Show" do
    setup [:create_service]

    test "displays service", %{conn: conn, service: service} do
      {:ok, _show_live, html} = live(conn, Routes.service_show_path(conn, :show, service))

      assert html =~ "Show Service"
      assert html =~ service.api_spec
    end

    test "updates service within modal", %{conn: conn, service: service} do
      {:ok, show_live, _html} = live(conn, Routes.service_show_path(conn, :show, service))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Service"

      assert_patch(show_live, Routes.service_show_path(conn, :edit, service))

      assert show_live
             |> form("#service-form", service: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#service-form", service: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.service_show_path(conn, :show, service))

      assert html =~ "Service updated successfully"
      assert html =~ "some updated api_spec"
    end
  end
end
