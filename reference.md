
### Built-in Color Variables in Textual

The table below lists the primary built-in design variables provided by Textual themes:

| Variable | Description | Typical Use Case |
| :--- | :--- | :--- |
| **`$background`** | The base background color of the application screen. | Standard screen backgrounds. |
| **`$surface`** | A slightly lighter/different container color than the background. | Nested containers, widgets, and cards. |
| **`$boost`** | A color with alpha (transparency) offsets to create depth. | Creating a subtle "popped out" layer on a background. |
| **`$panel`** | A color reserved for distinct dashboard or UI panels. | Sidebar backgrounds or terminal panels. |
| **`$primary`** | The main dominant color of the current theme. | Headers, key highlights, or focused inputs. |
| **`$secondary`** | A supporting brand or UI color. | Sub-headers, secondary actions, or labels. |
| **`$accent`** | A high-contrast call-to-action or highlight color. | Active/focused states, selections, or main buttons. |
| **`$success`** | Indicates success or positive states (usually green). | Successful operations, completed status. |
| **`$warning`** | Indicates warnings or pending items (usually yellow/amber). | Warning states, alerts, or incomplete tasks. |
| **`$error`** | Indicates errors or critical issues (usually red). | Input validation errors, failure alerts, deletion. |
| **`$text`** | The default foreground color for legible text. | Labels, paragraph text. |

---

### How to Increase Border Thickness

Because terminal screens are character-based rather than pixel-based, you cannot increase border thickness by setting pixel values (like `border-width: 4px`). 

Instead, you change the thickness in Textual by using **heavier Unicode border styles**.

The standard format is:
```css
border: <border-style> <border-color>;
```

#### Available Thick/Heavy Border Styles:
*   **`heavy`**: Uses bold, heavy single lines.
*   **`double`**: Uses double thin lines.
*   **`thick`**: Consistently thick solid block lines.
*   **`outer`**: Solid borders utilizing the character boundaries to appear thicker.
*   **`inner`**: A thick solid block outline drawn slightly inside.

#### Example CSS:
```css
#main-container {
    /* Changes the standard line to a thick block border */
    border: thick $accent; 
}
```