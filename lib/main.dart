import 'dart:io';

void main() {
  // Restaurant Menu
  Map<String, double> menu = {
    "Burger": 5.99,
    "Pizza": 8.99,
    "Pasta": 7.99,
    "Salad": 4.99,
    "Soda": 1.99,
  };

  // Show Welcome Message
  void showWelcome() {
    print("\nWelcome to Simple Restaurant System!");
    print("-" * 30);
  }

  // Display Menu
  void displayMenu() {
    print("\nMenu:");
    menu.forEach((item, price) {
      print("$item: \$${price.toStringAsFixed(2)}");
    });
  }

  // Take Order
  Map<String, int> takeOrder() {
    Map<String, int> order = {};
    while (true) {
      stdout.write(
          "\nEnter the item you'd like to order (type 'done' to finish): ");
      String? input = stdin.readLineSync();
      String item = (input ?? "").trim().capitalize();
      if (item == "Done") {
        break;
      }
      if (menu.containsKey(item)) {
        stdout.write("How many $item(s) would you like? ");
        int? quantity = int.tryParse(stdin.readLineSync() ?? "0");
        if (quantity != null && quantity > 0) {
          if (order.containsKey(item)) {
            order[item] = order[item]! + quantity;
          } else {
            order[item] = quantity;
          }
        } else {
          print("Invalid quantity. Please enter a valid number.");
        }
      } else {
        print("Item not available. Please choose from the menu.");
      }
    }
    return order;
  }

  // Calculate Total and Print Receipt
  double calculateTotal(Map<String, int> order) {
    double total = 0.0;
    print("\nYour Order Receipt:");
    print("-" * 30);
    order.forEach((item, quantity) {
      double price = menu[item]! * quantity;
      print("$item x $quantity = \$${price.toStringAsFixed(2)}");
      total += price;
    });
    print("-" * 30);
    return total;
  }

  // Main Program Logic
  showWelcome();
  while (true) {
    displayMenu();
    Map<String, int> order = takeOrder();
    if (order.isEmpty) {
      print("You didn't order anything. Thank you for visiting!");
      break;
    }
    double total = calculateTotal(order);
    print("Total Amount: \$${total.toStringAsFixed(2)}");
    print("Thank you for your order!");

    // Restart or Exit
    stdout.write("\nWould you like to make another order? (yes/no): ");
    String? restart = stdin.readLineSync();
    if (restart == null || restart.toLowerCase() != "yes") {
      print("Goodbye! Have a great day!");
      break;
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    return this.isEmpty ? this : '${this[0].toUpperCase()}${this.substring(1).toLowerCase()}';
  }
}
