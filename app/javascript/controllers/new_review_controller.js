import { Tab } from "bootstrap"
import { Controller } from "stimulus"
export default class extends Controller {
  static targets = ["duration", "tab", "form"]
  static values = {
    seconds: Number
  }

  connect() {
    this.timer = 0
    this.listener()
    this.durationTarget.innerText = this.formatTime(this.secondsValue)
  }

  listener() {
    this.tabTarget.addEventListener(("click"), (event) => {
      this.formTarget.classList.toggle("d-table")
      this.formTarget.classList.toggle("d-none")
    })
  }


  formatTime(seconds) {
    const hours = Math.floor(seconds / 3600)
    const minutes = Math.floor((seconds % 3600) / 60)
    seconds = seconds % 60
    return (
      String(hours).padStart(2, "0") +
      ":" +
      String(minutes).padStart(2, "0") +
      ":" +
      String(seconds).padStart(2, "0")
    )
  }

  disconnect() {
    if (this.timer) {
      clearInterval(this.timer)
    }
  }
}
