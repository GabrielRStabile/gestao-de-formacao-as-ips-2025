// utils/nifValidator.js
/**
 * Valida NIF português (9 dígitos, dígito de controlo correto)
 * @param {string} nif
 * @returns {boolean}
 */
function isValidNIF(nif) {
  if (!/^\d{9}$/.test(nif)) return false;
  let sum = 0;
  for (let i = 0; i < 8; i++) {
    sum += Number(nif[i]) * (9 - i);
  }
  let checkDigit = 11 - (sum % 11);
  if (checkDigit >= 10) checkDigit = 0;
  return checkDigit === Number(nif[8]);
}

module.exports = isValidNIF;
