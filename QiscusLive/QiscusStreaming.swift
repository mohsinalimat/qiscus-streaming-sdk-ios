//
//  QiscusLive.swift
//  Qiscus-Streaming
//
//  Created by asharijuang on 5/10/17.
//  Copyright © 2017 asharijuang. All rights reserved.
//

import UIKit

public class QiscusStreaming: NSObject {
    var manager = StreamManager.shared
    public static var shared    = QiscusStreaming()
    class var bundle:Bundle{
        get{
            let podBundle   = Bundle(for: QiscusStreaming.self)
            
            if let bundleURL = podBundle.url(forResource: "QiscusLive", withExtension: "bundle") {
                return Bundle(url: bundleURL)!
            }else{
                return podBundle
            }
        }
    }
    
    public override init() {
        super.init()
    }
    
    public init(withConfig config: StreamConfig) {
        manager.config    = config
    }
    
    public func setup(WithAppId id: String) {
        let config      = StreamConfig()
        config.AppId    = id
        self.manager.config = config
    }
    
    /**
     Get Stream window.
     
     - returns : Callback chat view controller and error if exist
     
     */
    public func buildStream(streamUrl url: String, completionHandler: @escaping (UIViewController, NSError?) -> Void) {
        self.manager.streamView(streamUrl: url) { (target, error) in
            completionHandler(target, error)
        }
    }
    
    /**
     Get Stream URL.
     
     - returns : Callback stream url
     
     */
    public func createStream(title: String, tags: [String], completion: @escaping (Stream?) -> Void) {
        self.manager.createStream(title: title, tags: tags, completion: completion)
    }
    
}
