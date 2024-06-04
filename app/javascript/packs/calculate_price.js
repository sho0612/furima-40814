document.addEventListener('DOMContentLoaded', () => {
  const priceInput = document.getElementById('item-price');
  const addTaxPrice = document.getElementById('add-tax-price');
  const profit = document.getElementById('profit');

  if (priceInput) {
    priceInput.addEventListener('input', () => {
      const price = parseInt(priceInput.value, 10);

      if (isNaN(price)) {
        addTaxPrice.innerText = '';
        profit.innerText = '';
        return;
      }

      const fee = Math.floor(price * 0.1);
      const profitAmount = price - fee;

      addTaxPrice.innerText = fee.toLocaleString();
      profit.innerText = profitAmount.toLocaleString();
    });
  }
});
