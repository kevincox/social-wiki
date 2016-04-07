//= require jquery
//= require jquery_ujs
//= require turbolinks

$(document).delegate(".votes form", "submit", function(event){
  event.preventDefault();
  
  var up = this.parentNode.querySelector(".up");
  var down = this.parentNode.querySelector(".down");
  var score = this.parentNode.querySelector(".score");
  
  var weight, change, old_active, new_active;
  if (this.matches(".active")) {
    weight = 0;
    change = this == up? -1 : 1;
    old_active = this;
  } else if (this == up) {
    weight = 1;
    change = down.matches(".active")? 2 : 1;
    new_active = this;
    old_active = down;
  } else if (this == down) {
    weight = -1;
    change = up.matches(".active")? -2 : -1;
    new_active = this;
    old_active = up;
  } else {
    return console.error("Unexpected vote button.", this);
  }
  
  var req = $.ajax({
    method: "POST",
    url: this.getAttribute("data-target"),
    data: {
      weight: weight,
    },
    
    success: () => {
      this.classList.remove("pending");
      if (old_active) old_active.classList.remove("active");
      if (new_active) new_active.classList.add("active");
      score.textContent = +score.textContent + change;
    },
    error: (_1, _2, msg) => {
      this.classList.remove("pending");
      console.error("Error voting", msg, req);
    },
  })
  
  this.classList.add("pending");
})
