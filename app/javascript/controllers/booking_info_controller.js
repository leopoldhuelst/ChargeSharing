import { Controller } from "stimulus"
export default class extends Controller {
  static targets = ["cost", "time", "realbutton", "fakebutton"]
  static values = {
    costPerMin: Number,
    seconds: Number,
    cost: { type: Number, default: 0 }
  }

  connect() {
    console.log(this.secondsValue)
    console.log(this.realbuttonTarget)
    console.log(this.fakebuttonTarget)
    this.timer = setInterval(() => {
      this.setTimeAndCost()
    }, 1000)
  }

  setTimeAndCost() {
    this.secondsValue += 1
    this.costValue = this.secondsValue * (this.costPerMinValue / 900)
    this.timeTarget.innerText = this.formatTime(this.secondsValue)
    this.costTarget.innerText = `${String(this.costValue.toFixed(2))}€`
    if (this.costValue < 0.50) {
      this.fakebuttonTarget.innerText = `${50 - (this.costValue * 100).toFixed(0)} cents left until you can stop booking`
    } else {
      this.fakebuttonTarget.classList.add("d-none")
      this.realbuttonTarget.classList.remove("d-none")
    }
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
