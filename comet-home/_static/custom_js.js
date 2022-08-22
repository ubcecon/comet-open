
document.addEventListener('DOMContentLoaded', function() {
//    document.getElementById("__navigation").checked = true;

 //Accordion Boxes w/o JQuery
 //Adapted from https://www.w3schools.com/howto/howto_js_accordion.asp

 var acc = document.getElementsByClassName("njqaccordion");
 var i;
 
 for (i = 0; i < acc.length; i++) {
   acc[i].addEventListener("click", function() {
     /* Toggle between adding and removing the "active" class,
     to highlight the button that controls the panel */
     this.classList.toggle("njqactive");
 
     /* Toggle between hiding and showing the active panel */
     var panel = this.nextElementSibling;
     if (panel.style.display === "block") {
       panel.style.display = "none";
     } else {
       panel.style.display = "block";
     }
   });
 }
 
 }, false);


