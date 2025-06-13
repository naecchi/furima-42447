function setupPriceCalculation() {   
  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");

  if (!priceInput || !addTaxDom || !profitDom) return;

  priceInput.addEventListener("input", () => {
    const inputValue = parseInt(priceInput.value);

    if (!isNaN(inputValue)) {
      const tax = Math.floor(inputValue * 0.1);       // 販売手数料（10%）
      const profit = inputValue - tax;                // 販売利益（価格 - 手数料）

      addTaxDom.innerHTML = `${tax}円`;               // 表示：販売手数料
      profitDom.innerHTML = `${profit}円`;            // 表示：販売利益
    } else {
      addTaxDom.innerHTML = "0円";
      profitDom.innerHTML = "0円";
    }
  });
}

window.addEventListener('turbo:load', setupPriceCalculation);
window.addEventListener('turbo:render', setupPriceCalculation);