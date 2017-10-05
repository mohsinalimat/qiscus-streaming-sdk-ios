//
//  ViewController.swift
//  Example
//
//  Created by asharijuang on 5/10/17.
//  Copyright © 2017 asharijuang. All rights reserved.
//

import UIKit
import QiscusLive

class ViewController: UIViewController {

    var client : QiscusStream = QiscusStream()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let config = StreamConfig.init(AppId: "Qiscus")
        self.client.setup(config: config)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func tapSample(_ sender: Any) {
        client.getStreamVC { (target, error) in
            self.navigationController?.pushViewController(target, animated: true)
        }
    }
}

