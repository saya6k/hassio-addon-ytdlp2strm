# Home Assistant Add-on: ytdlp2STRM

This add-on provides a web service that converts streams from platforms like YouTube, Twitch, Crunchyroll, etc., into STRM files.

## Configuration

**Note**: _Remember to restart the add-on when the configuration is changed._

### Option: `force_update`

When the add-on is launched, the initial configuration is made from the Supervisor config.
After that, custom configuration from the Supervisor is not possible.
This option forces the removal of the existing setup and creates a new initial configuration from the Supervisor config.

### Option: `host`

By default, this is defined as `addon.hostname`.
You can customize it with values like `192.168.1.124` or `ytdlp2strm.local`.

### Option: `port`

By default, this is defined as `addon.port`.
When using a reverse proxy, you can customize this to 80 or 443 as needed.

### Option: `keep_old_stream`

ytdlp2STRM automatically deletes old streams.

If you set this option to `true`, old streams will be preserved by default.

### Option: `temp_file_duration`

You can customize how long temporary files last.

The default is 86,400 seconds (which equals 1 day).

### Option: `cron_youtube`, `cron_twitch`

- `every`: This value can be customized from seconds to weeks (in plural form).
- `qty`: An integer from 1 to 60.
- `timezone`: A custom timezone for each cron.
- `do`:
  - `direct`: A simple redirect to the final stream URL (faster, no disk usage, SponsorBlock doesn't work). Twitch currently only supports direct mode.
  - `bridge`: Remuxing on the fly (fast, no disk usage).
  - `download`: First downloads the full video, then serves it (slower, uses temporary disk space).

### Option: `youtube_channel_list`, `twitch_channel_list`

You can add URLs like `https://www.youtube.com/@ytnnews24/streams` or `https://www.twitch.tv/riotgames`.

Multiple URLs can be added.

### Option: `log_level`

The `log_level` option controls the level of log output from the add-on. It can be adjusted to show more or less detail, which is useful when troubleshooting. Possible values include:

- `trace`: Shows every detail, including all called internal functions.
- `debug`: Displays detailed debug information.
- `info`: Displays normal, generally interesting events.
- `warning`: Shows exceptional occurrences that are not errors.
- `error`: Displays runtime errors that do not require immediate action.
- `fatal`: Displays critical issues that render the add-on unusable.

## Usage

By default, you can access web GUI `homeassistant.local:5005`.

Your strm files and metadata files are stored in `/media/Youtube` and `/media/Twitch`.

Find more information from [here](https://github.com/fe80Grau/ytdlp2STRM)

## License

This software is published under the terms of the GPLv3 license. See the LICENSE file in the repository.

Parts of this package include software redistributed from third parties, which are subject to different licenses:

* [Bootstrap](https://github.com/twbs/bootstrap), MIT License
* [Font Awesome](https://github.com/FortAwesome/Font-Awesome), CC BY 4.0 License
* [jQuery](https://github.com/jquery/jquery), MIT License