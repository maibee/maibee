import consumer from "./consumer"

consumer.subscriptions.create("RemoveChannel", {
  received(data) {
    document.getElementById("market" + data.content.id).style.display = "none";
    document.getElementById("tmarket" + data.content.id).style.display = "none";
  }
});