import consumer from "./consumer"
consumer.subscriptions.create("RoomChannel", {
  received(data) {
          function whichIcon(name){
          if(name === "Bitcoin"){
            return `<img class="currency_image" src="https://dynamic-assets.coinbase.com/e785e0181f1a23a30d9476038d9be91e9f6c63959b538eabbc51a1abc8898940383291eede695c3b8dfaa1829a9b57f5a2d0a16b0523580346c6b8fab67af14b/asset_icons/b57ac673f06a4b0338a596817eb0a50ce16e2059f327dc117744449a47915cb2.png"></img>Bitcoin`
           }
          else if(name === "Dogecoin"){
            return `<img class="currency_image" src="https://assets.coingecko.com/coins/images/5/small/dogecoin.png?1547792256"></img>Dogecoin`
          }
          else if(name === "Litecoin"){
            return `<img class="currency_image" src="https://dynamic-assets.coinbase.com/f018870b721574ef7f269b9fd91b36042dc05ebed4ae9dcdc340a1bae5b359e8760a8c224bc99466db704d10a3e23cf1f4cd1ff6f647340c4c9c899a9e6595cd/asset_icons/984a4fe2ba5b2c325c06e4c2f3ba3f1c1fef1f157edb3b8ebbfe234340a157a5.png"></img>Litecoin`
          }
          else if(name === "炒作幣"){
            return `<img class="currency_image" src="http://163.20.160.14/~word/uploads/photos/19163.gif"></img>炒作幣`
          }
          else{
            return `<div class="no_img currency_image">${name}</div>${name}`
            }
          };
    let MarketTemplate = `
                          <div>${whichIcon(data.content[1])}</div>
                          <div>${data.content[0].amount}</div>
                          <div>${data.content[0].sell_price}</div>
                          <div>${data.content[2]}</div>
                          <div><a rel="nofollow" data-method="post" href = "/markets/${data.content[0].id}/bit">購買</a></div>
                          `
    let node = document.createElement('div')
    node.className= 'body_row'
    node.innerHTML= MarketTemplate
    node.id = "tmarket" + data.content[0].id
    console.log(node);
    
    document.getElementById("new_order").appendChild(node);
  }
});