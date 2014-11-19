# testfairy

A wercker step to deploy to Testfairy

[![wercker status](https://app.wercker.com/status/0e8139b4dbc92af6b9e3b573025face2/m "wercker status")](https://app.wercker.com/project/bykey/0e8139b4dbc92af6b9e3b573025face2)

## Release note

### 0.0.6

Use TLSv1 to connect to the TestFairy Apis. Thanks [@fredjean](https://github.com/fredjean)

## Options

### required

* `api_key` - TestFairy API key. See https://app.testfairy.com/settings for details.
* `apk_file` - APK file path

### optional

* `proguard_file` - Proguard mapping file path
* `testers_groups` - Comma-separated list of tester groups to be notified on the new build.
* `metrics` - Comma-separated list of metrics to record. View list below.
* `max_duration` - Maximum session recording length, eg 20m or 1h. Default is "10m". Use "unlimited" for unlimited sessions.
* `video` - Video recording settings "on", "off" or "wifi" for recording video only when wifi is available. Default is "on".
* `video_quality` - Video quality settings, "high", "medium" or "low". Default is "high".
* `video_rate` - Video rate recording in frames per second, default is "1.0".
* `icon_watermark` - Add a small watermark to app icon. Default is "off".
* `comment` - Additional release notes for this upload. This text will be added to email notifications.

## Available Metrics

* `cpu` - user/kernel usage statistics.
* `memory` - process private/shared memory statistics.
* `network` - process network utilization.
* `phone-signal` - phone signal strength.
* `logcat` - process logs from logcat (Adds android.permission.READ\_LOGS permission.)
* `gps` - raw GPS location data, if used by app.
* `battery` - battery status and drainage (Adds android.permission.BATTERY\_STATS permission.)
* `mic` - keep microphone audio data, if used by app.

Example
------

Add TESTFAIRY\_API\_KEY as deploy target or application environment valiable.

    deploy:
      steps:
        - fly1tkg/testfairy:
            api_key: $TESTFAIRY_API_KEY
            apk_file: app/build/outputs/apk/app-debug-unaligned.apk
