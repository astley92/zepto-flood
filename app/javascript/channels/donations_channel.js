import consumer from "./consumer"

consumer.subscriptions.create("DonationsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to the donations channel");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log(data);
    let total_amount_div = document.getElementById("total-amount-div");
    let latest_donations_div = document.getElementById("latest-donations-div");
    total_amount_div.innerHTML = data.total_amount_html;
    latest_donations_div.innerHTML = data.latest_donations_html;
  }
});
