class AppPricingCalculator {

  static double calculateTotalPrice(double productPrice, String location) {
    double taxAmount = getTax(productPrice, location);
    double shippingCost =calculateShippingCost(location);

    double totalPrice = productPrice +taxAmount+shippingCost;
    return totalPrice;
  }

  static String getShippingCost(double productPrice, String location) {
    double shippingCost = calculateShippingCost(location);
    return shippingCost.toStringAsPrecision(2);
  }

  static double getTax(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    return taxAmount;
  }

  static double getTaxRateForLocation(String location) {
    return 0.14;
  }

  static double calculateShippingCost(String location) {
    return 10;
  }

}