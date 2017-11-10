//
//  ViewController.swift
//  Example
//
//  Created by asharijuang on 5/10/17.
//  Copyright © 2017 asharijuang. All rights reserved.
//

import UIKit
import QiscusStreaming

class ViewController: UIViewController {

    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var buttonStream: UIButton!
    @IBOutlet weak var buttonLive: UIButton!
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tapSample(_ sender: Any) {
        client?.createStream(title: "streaming", tags: "email : juang@qiscus.co") { (stream) in
            print("stream url : \(String(describing: stream?.streamUrl))")
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
}

