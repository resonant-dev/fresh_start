defmodule FreshStartWeb.AreaLiveTest do
  use FreshStartWeb.ConnCase

  import Phoenix.LiveViewTest

  alias FreshStart.Planner

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp fixture(:area) do
    {:ok, area} = Planner.create_area(@create_attrs)
    area
  end

  defp create_area(_) do
    area = fixture(:area)
    %{area: area}
  end

  describe "Index" do
    setup [:create_area]

    test "lists all areas", %{conn: conn, area: area} do
      {:ok, _index_live, html} = live(conn, Routes.area_index_path(conn, :index))

      assert html =~ "Listing Areas"
      assert html =~ area.name
    end

    test "saves new area", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.area_index_path(conn, :index))

      assert index_live |> element("a", "New Area") |> render_click() =~
        "New Area"

      assert_patch(index_live, Routes.area_index_path(conn, :new))

      assert index_live
             |> form("#area-form", area: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#area-form", area: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.area_index_path(conn, :index))

      assert html =~ "Area created successfully"
      assert html =~ "some name"
    end

    test "updates area in listing", %{conn: conn, area: area} do
      {:ok, index_live, _html} = live(conn, Routes.area_index_path(conn, :index))

      assert index_live |> element("#area-#{area.id} a", "Edit") |> render_click() =~
        "Edit Area"

      assert_patch(index_live, Routes.area_index_path(conn, :edit, area))

      assert index_live
             |> form("#area-form", area: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#area-form", area: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.area_index_path(conn, :index))

      assert html =~ "Area updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes area in listing", %{conn: conn, area: area} do
      {:ok, index_live, _html} = live(conn, Routes.area_index_path(conn, :index))

      assert index_live |> element("#area-#{area.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#area-#{area.id}")
    end
  end

  describe "Show" do
    setup [:create_area]

    test "displays area", %{conn: conn, area: area} do
      {:ok, _show_live, html} = live(conn, Routes.area_show_path(conn, :show, area))

      assert html =~ "Show Area"
      assert html =~ area.name
    end

    test "updates area within modal", %{conn: conn, area: area} do
      {:ok, show_live, _html} = live(conn, Routes.area_show_path(conn, :show, area))

      assert show_live |> element("a", "Edit") |> render_click() =~
        "Edit Area"

      assert_patch(show_live, Routes.area_show_path(conn, :edit, area))

      assert show_live
             |> form("#area-form", area: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#area-form", area: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.area_show_path(conn, :show, area))

      assert html =~ "Area updated successfully"
      assert html =~ "some updated name"
    end
  end
end
