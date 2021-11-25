const markers = document.querySelectorAll(".marker")
// function popup {
//   console.log("Fuck yes")
// }

const logconsole = () => {
  console.log("Hola")
}

const bindEventToMarker = (marker) => {
  marker.addEventListener("click", logconsole);
};

markers.forEach(bindEventToMarker)
