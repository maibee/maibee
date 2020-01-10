import consumer from "./consumer"
consumer.subscriptions.create("RoomChannel", {
  received(data) {
    let MarketTemplate = `
                          <td>${data.content[1]}</td>
                          <td>${data.content[0].amount}</td>
                          <td>${data.content[0].sell_price}</td>
                          <td>${data.content[2]}</td>
                          <td>${data.content[0].num}</td>
                          <td><a class= "btn btn-primary" rel="nofollow" data-method="post" href = "/markets/${data.content[0].id}/bit">購買<a></td>
                          `
    let node = document.createElement('tr')
    node.innerHTML= MarketTemplate
    node.id = "market" + data.content[0].id
    node.className = "table"
    console.log(node);
    
    document.getElementById("new_order").appendChild(node);
  }
});