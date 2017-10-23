//
//  StreamManager.swift
//  Qiscus-Streaming
//
//  Created by asharijuang on 5/10/17.
//  Copyright © 2017 asharijuang. All rights reserved.
//

import UIKit
import LFLiveKit

class StreamManager: NSObject {
    var config : StreamConfig!
    static var shared = StreamManager()

    //MARK: - Getters and Setters
    var session: LFLiveSession = {
        let audioConfiguration = LFLiveAudioConfiguration.defaultConfiguration(for: LFLiveAudioQuality.high)
        let videoConfiguration = LFLiveVideoConfiguration.defaultConfiguration(for: LFLiveVideoQuality.low3)
        let session = LFLiveSession(audioConfiguration: audioConfiguration, videoConfiguration: videoConfiguration)
        return session!
    }()
    
    //MARK: - Event    
    func stopLive() -> Void {
        session.stopLive()
    }
    
    func streamView(streamUrl url: String, completionHandler: @escaping (UIViewController, NSError?) -> Void) {
        let target          = StreamVC()
        target.streamUrl    = url
        completionHandler(target, nil)
    }
    
    func createStream(title: String, tags: [String], completion: @escaping (Stream?) -> Void) {
        // Request URL
        StreamService.createStreaming(title: title, tags: tags) { (result) in
            if result != nil {
                completion(result)
            }else {
                completion(nil)
            }
        }
    }
}
