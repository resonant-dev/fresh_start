defmodule FreshStartWeb.LayoutView do
  use FreshStartWeb, :view

  def active_class(conn, path) do
    current_path = Path.join(["/" | conn.path_info])

    if path == current_path do
      "active"
    else
      nil
    end
  end

  # def active_link(conn, path, opts) do
  #   class =
  #     [opts[:class], active_class(conn, path)]
  #     |> Enum.filter(& &1)
  #     |> Enum.join(" ")

  #   opts =
  #     opts
  #     |> Keyword.put(:class, class)
  #     |> Keyword.put(:to, path)

  #   link(text, opts)
  # end
end
