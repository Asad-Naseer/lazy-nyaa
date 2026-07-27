from textual.widgets import ListItem, Label
from rich import print

class Custom_list_item(ListItem):
    def __init__(self, torrent_data, **kwargs): # Custom class' arguments that it will be receiving
        # Define custom display_text to show when we use our custom_list_item
        display_text = f"{torrent_data['title']}\n S:[green]{torrent_data['seeders']}[/green] L:[red]{torrent_data['leechers']}[/red] Size:{torrent_data['size']}\n"

        # Pass this to parent class to construct our custom_list_item.
        super().__init__(Label(display_text), **kwargs)

        # Define attributes that we want attached to our custom item.

        self.magnet_link = torrent_data['magnet_link']