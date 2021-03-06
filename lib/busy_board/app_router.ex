defmodule BusyBoard.AppRouter do
  use Plug.Router
  alias BusyBoard.Server
  
  @fourohfour """
  {
    "status": 404,
    "msg": "Oh no; not found :("
  }
  """
  
  plug :match
  plug :dispatch

  # HTML routes
  
  get "/" do
    send_html conn,
      200,
      read_static("index.html")
  end

  post "/register" do
    Server.put conn.params
    redirect(conn, "/")
  end

  # JSON routes
  
  get "/api", do: api_all(conn)
  get "/api/people", do: api_all(conn)

  match _, do: send_json(conn, 404, @fourohfour)

  # Private helpers

  defp static(file_path),
    do: Path.join(:code.priv_dir(:busy_board), "static/#{file_path}")

  defp redirect(conn, path) do
    conn
    |> Plug.Conn.put_resp_header("location", path)
    |> Plug.Conn.resp(302, "")
  end

  defp send_html(conn, status, content) do
    conn
    |> put_resp_content_type("text/html")
    |> send_resp(status, content)
  end

  defp send_json(conn, status, content) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status, content)
  end

  defp read_static(filename), do: static(filename) |> File.read!

  defp api_all(conn), do: send_json(conn, 200, Server.all |> Poison.encode!)
end
