import subprocess
import re
import json

def get_monitor_info():
    """
    Fetches the main monitor's resolution and physical size from `wlr-randr`.
    """
    try:
        # Run wlr-randr and capture its output
        output = subprocess.run(['wlr-randr'], capture_output=True, text=True, check=True).stdout

        # Split the output by monitor
        monitors_raw = re.split(r'^\S+', output, flags=re.MULTILINE)[1:]

        monitor_data = {}
        for monitor in monitors_raw:
            # Check for the primary monitor
            if 'Enabled: yes' in monitor and 'Modes:' in monitor:
                # Extract resolution (e.g., 2560x1440)
                resolution_match = re.search(r'(\d+x\d+).*?\(preferred,\s+current\)', monitor)
                # Extract physical size (e.g., 600x340 mm)
                size_match = re.search(r'Physical size: (\d+x\d+)\s+mm', monitor)

                if resolution_match and size_match:
                    resolution = resolution_match.group(1).split("x")
                    physical_size = size_match.group(1).split("x")

                    # Store the info for the enabled monitor
                    monitor_data = {
                        'resolution': (int(resolution[0]), int(resolution[1])),
                        'physical_size_mm': (int(physical_size[0]), int(physical_size[1]))
                    }
                    # We assume the first 'enabled' monitor found is the main one.
                    # You might need to refine this for multi-monitor setups.
                    pixel_per_cm_w = round(int(resolution[0]) / round(int(physical_size[0]) / 10))
                    pixel_per_cm_h = round(int(resolution[1]) / round(int(physical_size[1]) / 10))
                    assert(pixel_per_cm_w == pixel_per_cm_h)
                    font_size = round(-1 / 8 * pixel_per_cm_w + 15)
                    hyprpanel_size = round(-1 / 120 * pixel_per_cm_w + 16 / 15, 1)
                    result = {
                        "font": font_size,
                        "hyprpanel": hyprpanel_size
                    }
                    print(json.dumps(result))
                    return

    except FileNotFoundError:
        print("Error: `wlr-randr` command not found. Please ensure it's installed and in your PATH.")
        return None
    except subprocess.CalledProcessError as e:
        print(f"Error executing `wlr-randr`: {e}")
        return None

if __name__ == "__main__":
    get_monitor_info()
