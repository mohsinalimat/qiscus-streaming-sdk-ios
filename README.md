# Qiscus Streaming SDK IOS

[![Platform](https://img.shields.io/cocoapods/p/QiscusStreaming.svg?style=flat)](http://cocoapods.org/pods/QiscusStreaming) 
![Language](https://img.shields.io/badge/language-Swift%203.2-orange.svg) 
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
<key>NSCameraUsageDescription</key>
<string>..</string>
<key>NSMicrophoneUsageDescription</key>
<string>..</string>
```

# Authentication

### Init with Your API Key

Init Qiscus at your application class with your API key

`QiscusStreaming(withConfig: config)`

Parameters:
* config: StreamConfig

```swift
import QiscusStreaming

let config      = StreamConfig()
config.AppId    = "Your_app_id"
client = QiscusStreaming(withConfig: config)

```

Above is our demo API key with limited feature. To get your API key with full features, please [contact us](https://www.qiscus.com/contactus).

### Create Stream

Before user can start streaming each other, they must create link streaming

`QiscusStreaming.createStream(title: String, tags: [String], completion: @escaping (Stream?) -> Void)`

Parameters:
* title : String
* tags  : [String]
* completion: @escaping (String) -> Void

```swift
let config      = StreamConfig()
config.AppId    = "Your_app_id"
client = QiscusStreaming(withConfig: config)

client?.createStream(title: "streaming", tags: ["test"]) { (stream) in
    print("stream url : \(stream?.streamUrl)")
}
```

Stream object:
* streamUrl: String
* watchUrl: String

### Start Stream

Start video streaming

```swift
let config      = StreamConfig()
config.AppId    = "Your_app_id"
client = QiscusStreaming(withConfig: config)

client?.buildStream(streamUrl: url!, completionHandler: { (target, error) in
    self.present(target, animated: true, completion: nil)
})
```

You can obtain stream_url from stream object.

### Implementation

```swift
import QiscusStreaming

var client : QiscusStreaming?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        buttonStream.addTarget(self, action: #selector(self.tapSample(_:)), for: UIControlEvents.touchUpInside)
        buttonLive.addTarget(self, action: #selector(self.goStream(_:)), for: UIControlEvents.touchUpInside)
        let config      = StreamConfig()
        config.AppId    = "a3d2QkJXQ2M1YTdrTW1PYnVJSmJiUVczTkxmS3BRc05nYnRCOHRGUw=="
        client = QiscusStreaming(withConfig: config)
    }

    func tapSample(_ sender: Any) {
        client?.createStream(title: "streaming", tags: ["test"]) { (stream) in
            print("stream url : \(stream?.streamUrl)")
            self.urlTextField.text = stream?.streamUrl
        }
    }
    
    func goStream(_ sender: Any) {
        //
        let url = self.urlTextField.text
        client?.buildStream(streamUrl: url!, completionHandler: { (target, error) in
            //
            self.present(target, animated: true, completion: nil)
        })
    }
```

You can test live streaming using VLC(https://www.videolan.org/vlc/). 
Open Vlc, file, open network and put stream url after call method QiscusStream.createStream

<p align="center"><br/><img src="https://d1edrlpyc25xu0.cloudfront.net/kiwari-prod/image/upload/_ngkAgxn38/1507543773-Screen+Shot+2017-10-09+at+5.08.35+PM.png" width="45%" /><br/></p>

### Example

- [Basic example]
- [Qiscus Chat SDK integration]

