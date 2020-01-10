import ax from '../helpers/ax'

document.addEventListener("DOMContentLoaded", function(){
  console.log("ready");
  document.getElementById('notice_record').addEventListener("click", function(){
    
    
    if(this.getAttribute('name') === 'unread'){
      ax({
        method: 'post',
        url: '/records/zeroing',
        data: {
        }
      }).then(function (response) {
        console.log(response);
      })
      .catch(function (error) {
        console.log(error);
      });
      document.getElementById('bell').innerText= 0
      this.setAttribute('name', "read")
    }
  })
  
}); 
