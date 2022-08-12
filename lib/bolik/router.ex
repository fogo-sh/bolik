defmodule Bolik.Router do
  use Plug.Router
  use Plug.ErrorHandler

  plug(Plug.Logger)
  plug(Bolik.Cors)
  plug(:match)

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart],
    pass: ["*/*"]
  )

  plug(:dispatch)

  post "/" do
    %{"image" => %{path: path, content_type: content_type}, "args" => raw_args} = conn.body_params

    args = Jason.decode!(raw_args)

    Enum.reduce(args, Mogrify.open(path), fn arg, acc ->
      [{key, value}] = Map.to_list(arg)
      Mogrify.custom(acc, key, value)
    end)
    |> Mogrify.save(in_place: true)

    conn
    |> put_resp_content_type(content_type)
    |> send_resp(200, File.read!(path))
  end

  match _ do
    conn |> send_resp(404, "oops")
  end

  defp handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack}) do
    conn |> send_resp(conn.status, "Something went wrong")
  end
end
