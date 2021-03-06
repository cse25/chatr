defmodule ChatrWeb.Router do
  use ChatrWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug ChatrWeb.Plugs.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ChatrWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/rooms", RoomController
    get "/users", UserController, :index
    get "/signin", UserController, :new
    get "/signout", UserController, :signout
    resources "/users", UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", ChatrWeb do
  #   pipe_through :api
  # end
end
