//
//  GameInterfaceController.swift
//  PacManWatch WatchKit Extension
//
//  Created by Wilson Gramer on 9/2/17.
//  Copyright © 2017 Neef.co. All rights reserved.
//

import WatchKit
import Foundation

class GameInterfaceController: WKInterfaceController {
    
    @IBOutlet var pacmanSequencePicker: WKInterfacePicker!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        let pickerItems: [WKPickerItem] = (0...9).map {
            let pickerItem = WKPickerItem()
            pickerItem.contentImage = WKImage(imageName: "pacman-pos-\(($0) - 1)")
            return pickerItem
        }
        pacmanSequencePicker.setItems(pickerItems)
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func pickerSelectedItemChanged(value: Int) {
        if value == 9 {
            pacmanSequencePicker.setSelectedItemIndex(1)
        }
        if value == 0 {
            pacmanSequencePicker.setSelectedItemIndex(8)
        }
    }
}

