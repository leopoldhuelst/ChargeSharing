import { Controller } from "stimulus"
export default class extends Controller {
  static targets = ["cost", "time"]
  static values = {
    costPerSecond: Number,
    seconds: Number
  }

  connect() {
    console.log("morning")
    console.log(this.costTarget)
    console.log(this.timeTarget)
    console.log(typeof this.costPerSecondValue)
    console.log(typeof this.secondsValue)
    let cost_per_second = this.costPerSecondValue / 900
    let cost = 0

    const setTimeAndCost = () => {
      this.timeTarget.innerText = formatTime(this.secondsValue);
      this.costTarget.innerText = `$${String(cost.toFixed(2))}`
    }

    setInterval(function () {
      this.secondsValue += 1;
      cost = this.secondsValue * cost_per_second
      console.log(typeof cost)
      console.log(typeof this.secondsValue)
      setTimeAndCost()
      // this.timeTarget.innerText = formatTime(this.secondsValue);
      // this.costTarget.innerText = `$${String(cost.toFixed(2))}`
    }, 1000);

    function formatTime(seconds) {
      const hours = Math.floor(seconds / 3600)
      const minutes = Math.floor((seconds % 3600) / 60);
      seconds = seconds % 60;
      return (
        String(hours).padStart(2, '0') + ':' + String(minutes).padStart(2, '0') + ':' + String(seconds).padStart(2, '0')
      );
    }
  }
}
