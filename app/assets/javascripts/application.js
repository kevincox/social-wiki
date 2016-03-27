//= require jquery
//= require jquery_ujs
//= require turbolinks

$(document).delegate(".votes form", "submit", function(event){
  event.preventDefault();
  
  var weight, old_active, new_active;
  if (this.matches(".active")) {
    weight = 0;
    old_active = this;
  } else if (this.matches(".up")) {
    weight = 1;
    new_active = this;
    old_active = this.parentNode.querySelector(".down");
  } else if (this.matches(".down")) {
    weight = -1;
    new_active = this;
    old_active = this.parentNode.querySelector(".up");
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
    },
    error: (_1, _2, msg) => {
      this.classList.remove("pending");
      console.error("Error voting", msg, req);
    },
  })
  
  this.classList.add("pending");
})
