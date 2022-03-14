defmodule GlupWeb.Plugs.AuthPlug do
  alias Glup.Users
  import Plug.Conn

  use GlupWeb, :controller

  def init(options), do: options

  def call(conn, _opts) do
    IO.inspect conn
    allowed_actions = ["/signup", "/signup/"]

    if Enum.member?(allowed_actions, conn.request_path) do
      conn
    else
      case Users.validate_user(conn) do
        :ok ->
          conn
        :error ->
          conn
          |> put_status(:unauthorized)
          |> put_view(GlupWeb.ErrorView)
          |> Phoenix.Controller.render("401.json")
          |> halt
      end
    end

  end

end
