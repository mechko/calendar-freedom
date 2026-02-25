<p align="center">
  <img src="Calendar%20Freedom/Assets.xcassets/AppIcon.appiconset/icon_256.png" width="128" alt="Calendar Freedom icon">
</p>

# Calendar Freedom

A macOS app that adds open-source and self-hosted video conferencing options to Apple Calendar's built-in video call picker — right alongside FaceTime.

## What it does

Calendar Freedom installs a Calendar extension that lets you create events with video conference links from providers like [Jitsi](https://jitsi.org/), [BigBlueButton](https://bigbluebutton.org/), [OpenTalk](https://opentalk.eu/), or any service with a URL-based meeting room.

When you create a new event in Calendar and click the video call dropdown, your configured room types appear as options next to FaceTime. Selecting one automatically generates and attaches a conference link to the event.

## Features

- **Multiple room types** — configure up to 5 different video conferencing providers
- **Random room IDs** — optionally generate a unique room link per event (great for Jitsi)
- **Fixed room URLs** — use a permanent personal meeting room URL (for BBB, OpenTalk, etc.)
- **Native Calendar integration** — room types appear directly in Calendar's video call picker
- **No network access required** — the extension runs entirely locally with no server communication

## Requirements

- macOS 15.0 (Sequoia) or later
- Xcode 26+ to build from source

## Building

1. Clone the repository:
   ```
   git clone https://github.com/mechko/calendar-freedom.git
   ```
2. Open `Calendar Freedom.xcodeproj` in Xcode
3. Select the "Calendar Freedom" scheme and build (Cmd+B)
4. Run the app and configure your room types in Preferences

## Installation

After building, copy `Calendar Freedom.app` to `/Applications/`. The Calendar extension registers automatically — you should see your configured room types in Calendar's video call picker when creating a new event.

You can verify the extension is registered:
```
pluginkit -mDvvv -p com.apple.calendar.virtualconference
```

## Usage

1. Launch Calendar Freedom and click "Manage Room Types..."
2. Add a room type with a name and base URL (e.g. `https://meet.jit.si`)
3. Enable "Add Random Room ID" if you want a unique link per event
4. Open Apple Calendar, create a new event, and select your room type from the video call dropdown

## License

This project is licensed under the [GNU General Public License v2.0](LICENSE).

### Third-party

The app icon uses the raised fist emoji from [Google Noto Emoji](https://github.com/googlefonts/noto-emoji), licensed under the [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0). See [THIRD_PARTY_LICENSES.txt](Calendar%20Freedom/THIRD_PARTY_LICENSES.txt) for the full license text.
