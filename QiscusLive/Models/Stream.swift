//
//  Stream.swift
//  QiscusLive
//
//  Created by asharijuang on 10/6/17.
//

import UIKit
import SwiftyJSON

open class StreamConfig : NSObject {
    public var AppId    : String = ""
    public var baseURL  : String = "http://rtmp-api.qiscus.com"
    
    public override init(){
        super.init()
    }
}

public class Stream: NSObject {
    var title       : String    = ""
    var name        : String    = ""
    var token       : String    = ""
    public var streamUrl   : String    = ""
    public var watchUrl    : String    = ""
    var playUrl     : String    = ""
    var hlsUrl      : String    = ""
    var tags        : [String]  = [String]()
    
    init(withJSON data: JSON) {
        self.title      = data["title"].stringValue
        self.streamUrl  = data["stream_url"].stringValue
        self.playUrl    = data["play_url"].stringValue
        self.watchUrl   = data["watch_url"].stringValue
        self.name       = data["name"].stringValue
    }
}
