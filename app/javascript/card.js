const pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    
    const formResult = document.getElementById("charge-form")
    const formData = new FormData(formResult);

    const card = {
      number: formData.get("consumer_address[number]"),
      exp_month: formData.get("consumer_address[exp_month]"),
      exp_year: `20${formData.get("consumer_address[exp_year]")}`,
      cvc: formData.get("consumer_address[cvc]")
    };

    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      };

      document.getElementById("card-number").removeAttribute("consumer_address[number]");
      document.getElementById("card-cvc").removeAttribute("consumer_address[cvc]");
      document.getElementById("card-exp-month").removeAttribute("consumer_address[exp_month]");
      document.getElementById("card-exp-year").removeAttribute("consumer_address[exp_year]");

      document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener("load", pay);