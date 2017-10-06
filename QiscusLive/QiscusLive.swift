//
//  QiscusLive.swift
//  Qiscus-Streaming
//
//  Created by asharijuang on 5/10/17.
//  Copyright © 2017 asharijuang. All rights reserved.
//

import UIKit

public class StreamConfig : NSObject {
    public var AppId    : String
    public var baseURL  : String
    
    public init(AppId : String, url : String) {
        self.AppId      = AppId
        self.baseURL    = url
    }
}

public class QiscusLive: NSObject {
    var manager = StreamManager.shared
    
    class var bundle:Bundle{
        get{
            let podBundle   = Bundle(for: QiscusLive.self)
            
            if let bundleURL = podBundle.url(forResource: "QiscusLive", withExtension: "bundle") {
                return Bundle(url: bundleURL)!
            }else{
                return podBundle
            }
        }
    }
    
    public override init() {
        
    }
    
    /**
     Get Stream window.
     
     - returns : Callback chat view controller and error if exist
     
     */
    public func getStreamVC(completionHandler: @escaping (UIViewController, NSError?) -> Void) {
        self.manager.streamView() { (target, error) in
            completionHandler(target, error)
        }
    }
    
}
