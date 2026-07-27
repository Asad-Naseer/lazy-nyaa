Here is a quick reference guide for using `ListView` and `ListItem` in Textual.

---

### 1. Imports
```python
from textual.widgets import ListView, ListItem, Label
```

---

### 2. Basic Structure & Composition
A `ListView` is a vertical, scrollable list container. Its immediate children must be `ListItem` widgets. `ListItem` is a generic container where you can place other UI elements (like `Label` or `Static`).

```python
class MyListApp(App):
    def compose(self) -> ComposeResult:
        yield ListView(
            ListItem(Label("First Item")),
            ListItem(Label("Second Item")),
            initial_index=0,  # Index to highlight initially (default is 0; use None to highlight nothing)
        )
```

---

### 3. Dynamic List Manipulation (Methods)
Always use these built-in methods on your `ListView` instance to modify items, as they ensure that the UI updates correctly. Do not modify `list_view.children` directly.

*   **`.append(item: ListItem)`**: Adds an item to the end of the list.
*   **`.extend(items: Iterable[ListItem])`**: Adds multiple items to the end of the list.
*   **`.insert(index: int, item: ListItem)`**: Inserts an item at a specific position.
*   **`.pop(index: int = -1) -> ListItem`**: Removes and returns the item at the given index.
*   **`.clear()`**: Removes all items from the list.

---

### 4. Key Properties
You can query or set these properties on your `ListView` instance at runtime:

*   **`list_view.index`**: Read/write `int | None`. 
    *   *Read:* Gets the index of the currently highlighted item (returns `None` if empty or nothing is focused).
    *   *Write:* Assigning an integer change highlights that index (e.g., `self.query_one(ListView).index = 2`).
*   **`list_view.highlighted_child`**: Read-only property returning the currently highlighted `ListItem` object, or `None` if nothing is highlighted.

---

### 5. Event Handling (Messages)
Define these methods inside your parent `App` or surrounding container widget to capture user actions:

```python
# Triggered when user presses 'Enter' or clicks on an item
def on_list_view_selected(self, message: ListView.Selected) -> None:
    # Key properties on the message object:
    selected_index = message.index          # The int index of the chosen item
    selected_item = message.item            # The actual ListItem object
    list_view_widget = message.list_view    # The ListView widget itself

# Triggered when the user navigates/moves focus (e.g., using Up/Down arrow keys)
def on_list_view_highlighted(self, message: ListView.Highlighted) -> None:
    highlighted_item = message.item         # Can be None if the list becomes empty
```

---

### 6. Common Recipes

#### A. Getting the text of a selected item
Because `ListItem` is a container, you must query its children to extract text:
```python
def on_list_view_selected(self, message: ListView.Selected) -> None:
    # Query the internal Label inside the selected ListItem
    label = message.item.query_one(Label)
    text = str(label.renderable)
    self.notify(f"Selected text: {text}")
```

#### B. Storing custom data on items (Subclassing)
To avoid manual widget querying, inherit from `ListItem` to bind custom payload data directly:
```python
class FileItem(ListItem):
    def __init__(self, filename: str, filepath: str) -> None:
        super().__init__(Label(filename))
        self.filepath = filepath # Bind custom data here

# Inside your selection handler:
def on_list_view_selected(self, message: ListView.Selected) -> None:
    if isinstance(message.item, FileItem):
        path = message.item.filepath
```

#### C. Disabling a ListItem
Disabled items are visible but skipped during keyboard navigation and cannot be clicked or highlighted.
```python
item = ListItem(Label("Non-clickable Item"))
item.disabled = True
```