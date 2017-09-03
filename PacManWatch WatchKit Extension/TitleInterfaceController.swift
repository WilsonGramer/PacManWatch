//
//  TitleInterfaceController.swift
//  PacManWatch WatchKit Extension
//
//  Created by Wilson Gramer on 9/2/17.
//  Copyright © 2017 Neef.co. All rights reserved.
//

import WatchKit
import Foundation

class TitleInterfaceController: WKInterfaceController {

    @IBOutlet var titleGifImageView: WKInterfaceImage!
    
    var timer = Timer()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        titleGifImageView.setImageNamed("titlegif-frame-")
        titleGifImageView.startAnimatingWithImages(in: NSMakeRange(0, 19), duration: 1, repeatCount: -1)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.playHapticOnTitleGif), userInfo: nil, repeats: true)
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        timer.invalidate()
    }
    
    @objc func playHapticOnTitleGif() {
        WKInterfaceDevice.current().play(.click)
    }

}
