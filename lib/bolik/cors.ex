defmodule Bolik.Cors do
  import Plug.Conn

  def init(options) do
    options
  end

  def call(conn, _params) do
    Plug.Conn.register_before_send(conn, fn conn ->
      conn
      |> put_resp_header("Access-Control-Allow-Origin", "*")
    end)
  end
end
