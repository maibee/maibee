import consumer from "./consumer"

consumer.subscriptions.create("CancelChannel", {
  received(data) {
    document.getElementById("tmarket" + data.content.id).style.display = "none";
  }
});