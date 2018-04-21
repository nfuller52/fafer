var stripe = Stripe($('meta[name="stripe-pub"]').attr("content"));
var elements = stripe.elements({ locale: "auto" });
var style = {
  iconStyle: "Solid",
  base: {
    // Add your base input styles here. For example:
    fontSize: "16px",
    color: "#32325d",
    fontSmoothing: "antialiased",
    "::placeholder": {
      color: "#fce883"
    }
  },
  invalid: {
    iconColor: "#ffc7ee",
    color: "#ffc7ee"
  }
};

var card = elements.create('card');
card.mount("#card-element");
card.addEventListener('change', function(event) {
  var displayError = document.getElementById('card-errors');
  if (event.error) {
    displayError.textContent = event.error.message;
  } else {
    displayError.textContent = '';
  }
});

function stripeTokenHandler(token) {
  // Insert the token ID into the form so it gets submitted to the server
  var form = document.getElementById('payment-form');
  var hiddenInput = document.createElement('input');
  hiddenInput.setAttribute('type', 'hidden');
  hiddenInput.setAttribute('name', 'stripe_token');
  hiddenInput.setAttribute('value', token.id);
  form.appendChild(hiddenInput);

  // Submit the form
  form.submit();
}

function createToken() {
  stripe.createToken(card).then(function(result) {
    if (result.error) {
      // Inform the user if there was an error
      var errorElement = document.getElementById('card-errors');
      errorElement.textContent = result.error.message;
    } else {
      // Send the token to your server
      stripeTokenHandler(result.token);
    }
  });
};

// Create a token when the form is submitted.
var form = document.getElementById('payment-form');
form.addEventListener('submit', function(e) {
  e.preventDefault();
  createToken();
});
