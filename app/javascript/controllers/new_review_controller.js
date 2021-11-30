import { Controller } from "stimulus"
export default class extends Controller {
  static targets = ["duration", "tab", "form", "submit"]
  static values = {
    seconds: Number
  }

  connect() {
    this.timer = 0
    this.review_listener()
    this.submit_listener()
    this.durationTarget.innerText = this.formatTime(this.secondsValue)
  }

  review_listener() {
    this.tabTarget.addEventListener(("click"), (event) => {
      this.formTarget.classList.toggle("d-table")
      this.formTarget.classList.toggle("d-none")
    })
  }

  submit_listener() {
      this.submitTarget.addEventListener("submit", (event) => {
        this.tabTarget.innerText = "Review saved"
        this.formTarget.classList.toggle("d-table")
        this.formTarget.classList.toggle("d-none")
        this.submitTarget.innerText = "Saved"
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
