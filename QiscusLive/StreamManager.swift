//
//  StreamManager.swift
//  Qiscus-Streaming
//
//  Created by asharijuang on 5/10/17.
//  Copyright © 2017 asharijuang. All rights reserved.
//

import UIKit

class StreamManager: NSObject {
    
    static var shared = StreamManager()

    func streamView(completionHandler: @escaping (UIViewController, NSError?) -> Void) {
        completionHandler(UIViewController(), nil)
    }
}
