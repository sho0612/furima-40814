document.addEventListener('turbo:load', () => {
  const priceInput = document.getElementById('item-price');
  const addTaxPrice = document.getElementById('add-tax-price');
  const profit = document.getElementById('profit');

  if (priceInput && addTaxPrice && profit) {
    priceInput.addEventListener('input', () => {
      const price = parseInt(priceInput.value, 10);

      if (isNaN(price) || price < 300 || price > 9999999) {
        addTaxPrice.innerText = '0';
        profit.innerText = '0';
        return;
      }

      const fee = Math.floor(price * 0.1);
      const profitAmount = price - fee;

      addTaxPrice.innerText = fee.toLocaleString();
      profit.innerText = profitAmount.toLocaleString();
    });
  }
});
