import {Controller} from "stimulus"
export default class extends Controller {
  static targets = ["menu", "button", "menuText", "menuContent"]
  toggleMenu() {
    console.log("toggleMenu")
    this.menuTarget.classList.toggle("show-menu")
    this.buttonTarget.classList.toggle("change-button")
    this.buttonTarget.classList.toggle("change-bars")
    // this.menuTextTarget.classList.toggle("d-none")
    // this.menuContentTarget.classList.toggle("move")
  }
}
