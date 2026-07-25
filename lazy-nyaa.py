from textual.app import App, ComposeResult
from textual.widgets import Header, Footer, Input, ListView, ListItem, Label
from textual import on
from textual.containers import Vertical

class lazy_nyaa(App):

    CSS_PATH = "./lazy-nyaa.tcss"

    examples = ["JJk", "OPM", "AOT"]


    def compose(self) -> ComposeResult:
        self.theme = "tokyo-night"

        with Vertical(id='main-container'):

            yield Input(placeholder="Type here to search")
            yield ListView(*[ListItem(Label(item)) for item in self.examples])
        





if __name__ == "__main__":
    lazy_nyaa().run()