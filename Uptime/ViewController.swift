//
//  ViewController.swift
//  Uptime
//
//  Created by Philipp Schunker on 08.04.19.
//  Copyright © 2019 Philipp Schunker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var hostnameLabel: UILabel!
    var uptimeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title="Uptime"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.readData))
        
        self.setupUI()
    }
    
    func setupUI() -> Void {
        var rect: CGRect = self.view.frame //as CGRect
        //rect.size.height=frame.size.width
        rect.size.height = 44
        //rect.size.width = 240
        //rect.size.width-=20.0
        rect.origin.x = (self.view.frame.width/2)-(rect.size.width/2)   //only needed if .textAlignment!=.center
        rect.origin.y += CGFloat(100)
        
        self.hostnameLabel = UILabel(frame: rect)
        
        guard let label = self.hostnameLabel else {
            return
        }
        
        self.view.addSubview(label)
        label.textAlignment = NSTextAlignment.center
        
        rect.origin.y += label.frame.size.height
        
        self.uptimeLabel = UILabel(frame: rect)
        
        if case let utimeLabel? = self.uptimeLabel {
            self.view.addSubview(utimeLabel)
            utimeLabel.textAlignment = NSTextAlignment.center
        }
    }
    
    @objc func readData() -> Void {
        let processInfo: ProcessInfo = ProcessInfo.processInfo
        NSLog("%@",processInfo.hostName)
        
        self.hostnameLabel.text = processInfo.hostName
        self.uptimeLabel.text = processInfo.systemUptime.description + " sec"
    }


}

