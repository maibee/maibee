import consumer from "./consumer"

consumer.subscriptions.create("RemoveChannel", {
  received(data) {
    // Called when there's incoming data on the websocket for this channel
    document.getElementById("market" + data.content.id).style.display = "none";
  }
});