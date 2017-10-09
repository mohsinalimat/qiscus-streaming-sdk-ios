# Qiscus Streaming SDK IOS

[![Platform](https://img.shields.io/cocoapods/p/QiscusStreaming.svg?style=flat)](http://cocoapods.org/pods/QiscusStreaming)
![Language](https://img.shields.io/badge/language-Swift%204.0-orange.svg)
[![CocoaPods](https://img.shields.io/cocoapods/v/QiscusStreaming.svg?style=flat)](http://cocoapods.org/pods/QiscusStreaming)

Qiscus Streaming SDK is a product that makes adding voice calling and/or instant messaging to mobile apps easy. It handles all the complexity of signaling and audio management while providing you the freedom to create a stunning user interface.

# Quick Start

Below is a step-by-step guide on setting up the Qiscus Streaming SDK for the first time

## Installation
### CocoaPods
```rb
source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

def import_pods
    pod 'QiscusStreaming'
end

target 'Your Target'  do
    platform :ios, '8.0'
    import_pods
end
````

### Permission

Add to your project Info.plist

```plist
```

# Authentication

### Init with Your API Key

Init Qiscus at your application class with your API key

#### `QiscusStreaming(withConfig: config)`

Parameters:
* config: StreamConfig

```Swift
import QiscusStreaming

let config      = StreamConfig()
config.AppId    = "Your_app_id"
client = QiscusStreaming(withConfig: config)

```

Above is our demo API key with limited feature. To get your API key with full features, please [contact us](https://www.qiscus.com/contactus).

### Create Stream

Before user can start streaming each other, they must create link streaming

#### `QiscusStreaming.createStream(stream_title, tags, callback);`

Parameters:
* title : String
* tags  : [String]
* completion: @escaping (String) -> Void

```Swift
var client : QiscusStream?
client?.createStream(title: "streaming", tags: ["test"]) { (streamUrl) in
            print("stream url : \(streamUrl)")
}
```

Stream object:
* streamUrl: String
* watchUrl: String

### Start Stream

Start video streaming

```java
QiscusStreaming.buildStream(stream_url)
                        .setVideoQuality(VideoQuality.QVGA)
                        .start(getContext());
```

You can obtain stream_url from stream object.

Video quality:
- VideoQuality.QVGA
- VideoQuality.SD
- VideoQuality.HD

### Implementation

```java
JSONObject tags = new JSONObject();

QiscusStreaming.createStream("Stream Test", tags, new CreateStreamListener() {
    @Override
    public void onCreateStreamSuccess(final QiscusStream stream) {
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                QiscusStreaming.buildStream(stream.streamUrl)
                                        .setVideoQuality(VideoQuality.QVGA)
                                        .start(getContext());
            }
        });
    }

    @Override
    public void onCreateStreamError(final String error) {
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                Toast.makeText(this, "Create stream error: " + error, Toast.LENGTH_SHORT).show();
            }
        });
    }
});
```
### Example

- [Basic example]
- [Qiscus Chat SDK integration]

