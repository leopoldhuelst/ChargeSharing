const stripeInit = () => {
  const stripeKey = document.getElementById("stripe-key").innerText
  const plugId = parseInt(document.getElementById("plug-id").innerText, 10)
  const stripe = Stripe(stripeKey)
  const elements = stripe.elements()
  const cardElement = elements.create('card');
  cardElement.mount('#card-element');

  // const cardNumber = elements.create('cardNumber');
  // cardNumber.mount('#card-number')
  // const cardExpiry = elements.create('cardExpiry');
  // cardExpiry.mount('#card-expiry')
  // const cardCvc = elements.create('cardCvc');
  // cardCvc.mount('#card-cvc')

  const cardholderName = document.getElementById('cardholder-name');
  const cardButton = document.getElementById('card-button');
  const resultContainer = document.getElementById('card-result');

  cardButton.addEventListener('click', function (ev) {
    console.log(cardElement)
    stripe.createPaymentMethod({
      type: 'card',
      card: cardElement,
      billing_details: {
        name: cardholderName.value,
      },
    }
    ).then(function (result) {
      if (result.error) {
        resultContainer.textContent = result.error.message;
      } else {
        // resultContainer.textContent = "Created payment method: " + result.paymentMethod.id;
        location.assign(`http://${window.location.host}/create_payment_id/${plugId}/${result.paymentMethod.id}`)
      }
    });
  });
}
export { stripeInit }
