# lazy-nyaa
### A Minimal TUI client for browsing torrents quickly on nyaa.si


<img width="997" height="686" alt="image" src="https://github.com/user-attachments/assets/03ba45bf-08c5-4e77-b229-6810f62aaebc" />


<img width="2553" height="1272" alt="image" src="https://github.com/user-attachments/assets/78650172-e87e-44c6-a5b7-816e021ce31a" />

### Install

**One Line Installer for Linux/Max**

```
curl -sSL https://raw.githubusercontent.com/Asad-Naseer/lazy-nyaa/main/install.sh | bash
```

**For Windows 11**

```
irm https://raw.githubusercontent.com/Asad-Naseer/lazy-nyaa/main/install.ps1 | iex
```

### Compile from source

1. Clone the repository to your desktop.
```
git clone "https://github.com/Asad-Naseer/lazy-nyaa.git"
```

2. Install uv (Python package installer and resolver written in Rust).

*   **macOS / Linux:**
    ```bash
    curl -LsSf https://astral.sh/uv/install.sh | sh
    ```
*   **Windows:**
    ```
    powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
    ```

3. In project folder:
```
uv sync
```

4. Run this pyinstaller command to make the binary for your specific operating system.

* **macOS / Linux:**
```bash
uv run pyinstaller --onefile --add-data "./lazy-nyaa.tcss:." --name lazy-nyaa lazy-nyaa.py
```
* **Windows:**
```powershell
uv run pyinstaller --onefile --add-data "./lazy-nyaa.tcss;." --name lazy-nyaa lazy-nyaa.py
```

5. You can find the binary in lazy-nyaa/dist.

### Use after building

**macOS and Linux**

Move the compiled binary to a directory that is already in your system's PATH, such as /usr/local/bin (system-wide) or ~/.local/bin (user-specific).

**Windows**

1. Open PowerShell and create a directory for your personal binaries (e.g., `C:\Users\<YourUsername>\bin`):
```powershell
New-Item -ItemType Directory -Force -Path "$HOME\bin"
```
2. Copy the compiled executable to this folder:
```powershell
Copy-Item -Path "dist\lazy-nyaa.exe" -Destination "$HOME\bin\"
```
3. Add this directory to your User PATH variable:
```powershell
[System.Environment]::SetEnvironmentVariable("PATH",[System.Environment]::GetEnvironmentVariable("PATH", "User") +";$HOME\bin","User")
```
4. Restart your terminal for the changes to apply. You can now run the tool from anywhere using:
```cmd
lazy-nyaa
```
