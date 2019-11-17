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
    var systemUptimeLabel: UILabel!
    var sysctlUptimeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Uptime"
        
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
        
        print(ColorCompatibility.label)
        
        //create hostnameLabel
        
        self.hostnameLabel = UILabel(frame: rect)
        
        guard let label = self.hostnameLabel else {
            return
        }
        
        label.textColor = ColorCompatibility.label;
        label.textAlignment = NSTextAlignment.center
        self.view.addSubview(label)
        
        //create systemUptimeLabel
        
        rect.origin.y += label.frame.size.height
        
        self.systemUptimeLabel = UILabel(frame: rect)
        
        if case let uptimeLabel? = self.systemUptimeLabel {
            uptimeLabel.textColor = ColorCompatibility.label
            uptimeLabel.textAlignment = NSTextAlignment.center
            self.view.addSubview(uptimeLabel)
        }
        
        //create sysctlUptimeLabel
        
        rect.origin.y += label.frame.size.height
        
        self.sysctlUptimeLabel = UILabel(frame: rect)
        
        if let sysUptimeLabel = self.sysctlUptimeLabel {
            sysUptimeLabel.textColor = ColorCompatibility.label
            sysUptimeLabel.textAlignment = NSTextAlignment.center
            self.view.addSubview(sysUptimeLabel)
        }
    }
    
    @objc func readData() -> Void {
        let processInfo: ProcessInfo = ProcessInfo.processInfo
        NSLog("%@",processInfo.hostName)
        
        self.hostnameLabel.text = processInfo.hostName
        self.systemUptimeLabel.text = processInfo.systemUptime.description + " sec"
        
        let bootTime: timeval = readKernelBootTime()
        
        var time: timeval = timeval(tv_sec: 0, tv_usec: 0)
        gettimeofday(&time, nil)
        
        //print(time)
        //print(bootTime)
        
        let uptime = Double(time.tv_sec - bootTime.tv_sec)
        print(uptime)
        self.sysctlUptimeLabel.text = String(uptime) + " sec"
    }
    
    func readKernelBootTime() -> timeval {
        var mib = [CTL_KERN, KERN_BOOTTIME]
        var bootTime = timeval()
        var size = MemoryLayout<timeval>.size
        //var size = strideof(timeval)

        if 0 != sysctl(&mib, UInt32(mib.count), &bootTime, &size, nil, 0) {
            fatalError("Could not get boot time, errno: \(errno)")
        }

        return bootTime
    }
}

