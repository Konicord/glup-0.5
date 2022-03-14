defmodule GlupWeb.UserController do
  use GlupWeb, :controller

  alias Glup.Users
  alias Glup.Users.User

  action_fallback GlupWeb.FallbackController

  def index(conn, _params) do
    user = Users.list_user()
    render(conn, "index.json", user: user)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Users.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)

    with {:ok, %User{} = user} <- Users.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)

    with {:ok, %User{}} <- Users.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def login(conn, _params) do
    conn
    |> put_status(:ok)
    |> render("status.json", %{status_code: "SUCCESS", attribute: ""})
  end

  def signup(conn, params) do
    signed_pwd = Users.sign_pwd(params["password"])
    user_params = %{
      "username" => params["username"],
      "password" => signed_pwd
    }
    with {:ok, %User{} = _user} <- Users.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render("status.json", %{status_code: "SUCCESS", attribute: ""})
    end
  end
end