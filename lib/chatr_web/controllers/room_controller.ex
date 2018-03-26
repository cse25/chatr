defmodule ChatrWeb.RoomController do
  use ChatrWeb, :controller

  alias Chatr.Repo
  alias Chatr.Chat
  alias Chatr.Chat.Room

  def index(conn, _params) do
    rooms = Repo.all(Room)
    render conn, "index.html", rooms: rooms
  end

  def new(conn, _params) do
    changeset = Room.changeset(%Room{}, %{})

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"room" => room} = params) do
    changeset = Room.changeset(%Room{}, room)

    case Repo.insert(changeset) do
      {:ok, _room} ->
        conn
        |> redirect(to: room_path(conn, :index))
        |> put_flash(:info, "Room Created")
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Error")
        render conn, "new.html", changeset: changeset
    end
  end

  def edit(conn, %{"id" => room_id}) do
    room = Repo.get!(Room, room_id)
    changeset = Room.changeset(room)

    render conn, "edit.html", changeset: changeset, room: room
  end

  # receives form
  def update(conn, %{"room" => room, "id" => room_id}) do
    previous_room = Chat.get_room!(room_id)
    changeset = Room.changeset(previous_room, room)

    case Repo.update(changeset) do
      {:ok, _room} ->
        conn
        |> redirect(to: room_path(conn, :index))
        |> put_flash(:info, "Room Title Updated")
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Error")
        render conn, "edit.html", changeset: changeset, room: previous_room
    end
  end

  def delete(conn, %{"id" => room_id}) do
    Repo.get!(Room, room_id)
    |> Repo.delete!

    conn
    |> put_flash(:info, "Room Deleted")
    |> redirect(to: room_path(conn, :index))
    |> halt()
  end
end

#
# +++++
# %Plug.Conn{adapter: {Plug.Adapters.Cowboy.Conn, :...}, assigns: %{},
#  before_send: [#Function<0.116143246/1 in Plug.CSRFProtection.call/2>,
#   #Function<4.106296412/1 in Phoenix.Controller.fetch_flash/2>,
#   #Function<0.112984571/1 in Plug.Session.before_send/2>,
#   #Function<1.10046047/1 in Plug.Logger.call/2>,
#   #Function<0.83265233/1 in Phoenix.LiveReloader.before_send_inject_reloader/2>],
#  body_params: %{},
#  cookies: %{"_chat_key" => "SFMyNTY.g3QAAAACbQAAAAtfY3NyZl90b2tlbm0AAAAYZFdQUWZWSllWeHIvbG1RdDl0Tk90dz09bQAAAAd1c2VyX2lkYQE.dmJYX515ksRLTX6KioLjctKw_9ZrClmY_eSAFEVjwPo",
#    "_chatr_key" => "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNzY3d3YyMTZtNldNc2lDaGNYMXV0UT09.ZzQ3PGXU3okl-mKo_utEKZsrY7dY6UZ2LhtEKJnveD0",
#    "_dixit_key" => "SFMyNTY.g3QAAAACbQAAAAtfY3NyZl90b2tlbm0AAAAYUzVtb0R0TmtkSzdJL2lIOVBtYUN4dz09bQAAAAd1c2VyX2lkYQM.TKwRiXoQ7BqgChg5e3cB4cdyHEtdcG0nXRK9ixP3T8o",
#    "_geo_key" => "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYQ3Q2TG85Z1VkQVRQdVZvVmR2dDU2Zz09.bpNze5ZK63IZIOk1tJmZigv6GhZiYw5FVNfMrBMC8p4",
#    "_reddit_key" => "SFMyNTY.g3QAAAAA.6sf7DhY7xZ4k6GC2X1QHgdYyBtr-Li5k0lfmJcg0HWg"},
#  halted: false, host: "localhost", method: "GET", owner: #PID<0.399.0>,
#  params: %{}, path_info: ["rooms", "new"], path_params: %{},
#  peer: {{127, 0, 0, 1}, 54723}, port: 4000,
#  private: %{ChatrWeb.Router => {[], %{}}, :phoenix_action => :new,
#    :phoenix_controller => ChatrWeb.RoomController,
#    :phoenix_endpoint => ChatrWeb.Endpoint, :phoenix_flash => %{},
#    :phoenix_format => "html", :phoenix_layout => {ChatrWeb.LayoutView, :app},
#    :phoenix_pipelines => [:browser], :phoenix_router => ChatrWeb.Router,
#    :phoenix_view => ChatrWeb.RoomView,
#    :plug_session => %{"_csrf_token" => "767wv216m6WMsiChcX1utQ=="},
#    :plug_session_fetch => :done}, query_params: %{}, query_string: "",
#  remote_ip: {127, 0, 0, 1},
#  req_cookies: %{"_chat_key" => "SFMyNTY.g3QAAAACbQAAAAtfY3NyZl90b2tlbm0AAAAYZFdQUWZWSllWeHIvbG1RdDl0Tk90dz09bQAAAAd1c2VyX2lkYQE.dmJYX515ksRLTX6KioLjctKw_9ZrClmY_eSAFEVjwPo",
#    "_chatr_key" => "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNzY3d3YyMTZtNldNc2lDaGNYMXV0UT09.ZzQ3PGXU3okl-mKo_utEKZsrY7dY6UZ2LhtEKJnveD0",
#    "_dixit_key" => "SFMyNTY.g3QAAAACbQAAAAtfY3NyZl90b2tlbm0AAAAYUzVtb0R0TmtkSzdJL2lIOVBtYUN4dz09bQAAAAd1c2VyX2lkYQM.TKwRiXoQ7BqgChg5e3cB4cdyHEtdcG0nXRK9ixP3T8o",
#    "_geo_key" => "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYQ3Q2TG85Z1VkQVRQdVZvVmR2dDU2Zz09.bpNze5ZK63IZIOk1tJmZigv6GhZiYw5FVNfMrBMC8p4",
#    "_reddit_key" => "SFMyNTY.g3QAAAAA.6sf7DhY7xZ4k6GC2X1QHgdYyBtr-Li5k0lfmJcg0HWg"},
#  req_headers: [{"host", "localhost:4000"}, {"accept-encoding", "gzip, deflate"},
#   {"cookie",
#    "_chatr_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNzY3d3YyMTZtNldNc2lDaGNYMXV0UT09.ZzQ3PGXU3okl-mKo_utEKZsrY7dY6UZ2LhtEKJnveD0; _dixit_key=SFMyNTY.g3QAAAACbQAAAAtfY3NyZl90b2tlbm0AAAAYUzVtb0R0TmtkSzdJL2lIOVBtYUN4dz09bQAAAAd1c2VyX2lkYQM.TKwRiXoQ7BqgChg5e3cB4cdyHEtdcG0nXRK9ixP3T8o; _reddit_key=SFMyNTY.g3QAAAAA.6sf7DhY7xZ4k6GC2X1QHgdYyBtr-Li5k0lfmJcg0HWg; _chat_key=SFMyNTY.g3QAAAACbQAAAAtfY3NyZl90b2tlbm0AAAAYZFdQUWZWSllWeHIvbG1RdDl0Tk90dz09bQAAAAd1c2VyX2lkYQE.dmJYX515ksRLTX6KioLjctKw_9ZrClmY_eSAFEVjwPo; _geo_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYQ3Q2TG85Z1VkQVRQdVZvVmR2dDU2Zz09.bpNze5ZK63IZIOk1tJmZigv6GhZiYw5FVNfMrBMC8p4"},
#   {"connection", "keep-alive"}, {"upgrade-insecure-requests", "1"},
#   {"accept", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"},
#   {"user-agent",
#    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/604.5.6 (KHTML, like Gecko) Version/11.0.3 Safari/604.5.6"},
#   {"referer", "http://localhost:4000/rooms/new"},
#   {"cache-control", "max-age=0"}, {"accept-language", "en-us"}],
#  request_path: "/rooms/new", resp_body: nil, resp_cookies: %{},
#  resp_headers: [{"cache-control", "max-age=0, private, must-revalidate"},
#   {"x-frame-options", "SAMEORIGIN"}, {"x-xss-protection", "1; mode=block"},
#   {"x-content-type-options", "nosniff"}, {"x-download-options", "noopen"},
#   {"x-permitted-cross-domain-policies", "none"}], scheme: :http,
#  script_name: [],
#  secret_key_base: "8wSuJn3W49caxvfKfRq+8hpIREldEtjUGke8OMq+442jiRhy0/eAuzfaJZNAPBHg",
#  state: :unset, status: nil}
# +++++
# %{}
# +++++
