class CartItem {
  String name;
  bool checked;

  CartItem(this.name, this.checked);
}


class AddItemAction {
  final CartItem item;

  AddItemAction(this.item);
}

class ToggleItemStateAction {
  final CartItem item;

  ToggleItemStateAction(this.item);
}



List<CartItem> cartItemsReducer(
    List<CartItem> items, dynamic action) {
  if (action is AddItemAction) {
    return addItem(items, action);
  } else if (action is ToggleItemStateAction) {
    return toggleItemState(items, action);
  }
  return items;
}

List<CartItem> addItem(List<CartItem> items, AddItemAction action) {
  return new List.from(items)..add(action.item);
}

List<CartItem> toggleItemState(
    List<CartItem> items, ToggleItemStateAction action) {
  List<CartItem> itemsNew = items
      .map((item) =>
  item.name == action.item.name ? action.item : item)
      .toList();
  return itemsNew;
}

