from textual.app import App, ComposeResult
from textual.widgets import Header, Footer, Input, ListView, ListItem, Label
from textual import on
from textual.containers import Vertical
from utils.process_query import process_query
from utils.custom_list_item import Custom_list_item
import webbrowser

class lazy_nyaa(App):

    BINDINGS = [
        ("o", "open_magnet_link", "Open Magnet Link")
    ]
    
    CSS_PATH = "./lazy-nyaa.tcss"
    user_input = ""
    results = []


    def compose(self) -> ComposeResult: # Compose only runs once at startup
        self.theme = "tokyo-night"
        with Vertical(id='main-container'):
            yield Input(placeholder="Type here to search")
            # yield ListView(*[ListItem(Label(item)) for item in self.examples])
            yield ListView(id='results-list')
        yield Label('Tab: Choose Focus\nArrow Keys: Nav Torrents\nClick/Enter: Copy Magnet Link\nO: Open in Default App\nCtrl+Q: Quit lazy-nyaa', id='guide')
        
    @on(Input.Submitted)
    async def send_to_process_query(self, event: Input.Submitted):
        results_list = self.query_one('#results-list', ListView)
        await results_list.clear()
        user_input = event.value.strip()
        results = process_query(user_input=user_input)
        self.results = results
        for result in results:
            results_list.insert(-1, [Custom_list_item(result)])

    @on(ListView.Selected)
    def copy_magnet(self, event:ListView.Selected):
        self.app.copy_to_clipboard(event.item.magnet_link)
        self.notify("Magnet Link Copied!")
        # webbrowser.open(event.item.magnet_link)

    def action_open_magnet_link(self):
        try:
            list_view = self.query_one("#results-list", ListView)
        except Exception:
            return
        
        if list_view.highlighted_child and list_view.has_focus:
            # self.app.copy_to_clipboard(list_view.highlighted_child.magnet_link)
            # self.notify("Magnet Link Copied!")
            webbrowser.open(list_view.highlighted_child.magnet_link)
            self.notify("Opening in default app.")

if __name__ == "__main__":
    lazy_nyaa().run()