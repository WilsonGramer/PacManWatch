//
//  GameInterfaceController.swift
//  PacManWatch WatchKit Extension
//
//  Created by Wilson Gramer on 9/2/17.
//  Copyright © 2017 Neef.co. All rights reserved.
//

import WatchKit
import Foundation

enum PacManItemTypes {
    case typeDot
    case typeFruit
    case typeGhost
    
    case errorType
}

enum PacManItems {
    case dot
    case dot_large
    
    case ghost_red
    case ghost_blue
    case ghost_pink
    case ghost_orange
    
    case fruit_apple
    case fruit_orange
    case fruit_cherry
    case fruit_strawberry
    
    case errorType
}

enum PacManCharacterDirection {
    case E
    case SE
    case S
    case SW
    case W
    case NW
    case N
    case NE
    
    case errorType
}

enum PacManInteractionType {
    case ghostInteraction
    case dotInteraction
    case largeDotInteraction
    case fruitInteraction
    case noInteraction
    
    case errorType
}

extension WKInterfaceImage {
    var imageName: String { return "ERROR" }
}

class GameInterfaceController: WKInterfaceController {
    
    @IBOutlet var box_topleft: WKInterfaceImage!
    @IBOutlet var box_topcenter: WKInterfaceImage!
    @IBOutlet var box_topright: WKInterfaceImage!
    
    @IBOutlet var box_centerleft: WKInterfaceImage!
    @IBOutlet var pacmanSequencePicker: WKInterfacePicker!
    @IBOutlet var box_centerright: WKInterfaceImage!
    
    @IBOutlet var box_bottomleft: WKInterfaceImage!
    @IBOutlet var box_bottomcenter: WKInterfaceImage!
    @IBOutlet var box_bottomright: WKInterfaceImage!
    
    @IBOutlet var scoreLabel: WKInterfaceLabel!
    
    var pacManInteractionType: PacManInteractionType = .errorType
    var selectedBoxImageName: String = "ERROR"
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        initGame()
        
        //while(true) { mainGameLoop() }
        mainGameLoop()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        
        //TODO: Write scores to plist
    }
    
    @IBAction func pickerSelectedItemChanged(letValue: Int) {
        var varValue = letValue
        if letValue == 9 {
            pacmanSequencePicker.setSelectedItemIndex(1)
            varValue = 1
        }
        if letValue == 0 {
            pacmanSequencePicker.setSelectedItemIndex(8)
            varValue = 8
        }
        
        pacManInteractionType = checkPacManInteraction(checkPacManDirection(varValue))
    }
    
    func initGame() {
        let pickerItems: [WKPickerItem] = (0...9).map {
            let pickerItem = WKPickerItem()
            pickerItem.contentImage = WKImage(imageName: "pacman-pos-\(($0) - 1)")
            return pickerItem
        }
        pacmanSequencePicker.setItems(pickerItems)
    }
    
    func mainGameLoop() {
        let (selectedBox, selectedItem) = createItemRandomly()
        
        
    }
    
    func createItemRandomly() -> (WKInterfaceImage, PacManItems) {
        let rand_box = Int(arc4random_uniform(8) + 1)
        var selectedBox: WKInterfaceImage!
        var selectedItemType: PacManItemTypes = .errorType
        var selectedItem: PacManItems = .errorType
        
        switch rand_box {
        case 1:
            selectedBox = self.box_topleft
        case 2:
            selectedBox = self.box_topcenter
        case 3:
            selectedBox = self.box_topright
        case 4:
            selectedBox = self.box_centerleft
        case 5:
            selectedBox = self.box_centerright
        case 6:
            selectedBox = self.box_bottomleft
        case 7:
            selectedBox = self.box_bottomcenter
        case 8:
            selectedBox = self.box_bottomright
        default:
            scoreLabel.setText("ERROR 1")
        }
        
        let rand_item = Int(arc4random_uniform(8) + 1)
        
        switch rand_item {
        case 1:
            selectedItemType = .typeDot
        case 2:
            selectedItemType = .typeDot
        case 3:
            selectedItemType = .typeDot
        case 4:
            selectedItemType = .typeDot
        case 5:
            selectedItemType = .typeDot
        case 6:
            selectedItemType = .typeDot
        case 7:
            selectedItemType = .typeGhost
        case 8:
            selectedItemType = .typeFruit
        default:
            scoreLabel.setText("ERROR 2")
        }
        
        switch selectedItemType {
        case .typeDot:
            let rand_category = Int(arc4random_uniform(3) + 1)
            switch rand_category {
            case 1:
                selectedItem = .dot
            case 2:
                selectedItem = .dot
            case 3:
                selectedItem = .dot_large
            default:
                scoreLabel.setText("ERROR 3A")
            }
        case .typeGhost:
            let rand_category = Int(arc4random_uniform(4) + 1)
            switch rand_category {
            case 1:
                selectedItem = .ghost_red
            case 2:
                selectedItem = .ghost_blue
            case 3:
                selectedItem = .ghost_pink
            case 4:
                selectedItem = .ghost_orange
            default:
                scoreLabel.setText("ERROR 3B")
            }
        case .typeFruit:
            let rand_category = Int(arc4random_uniform(4) + 1)
            switch rand_category {
            case 1:
                selectedItem = .fruit_apple
            case 2:
                selectedItem = .fruit_cherry
            case 3:
                selectedItem = .fruit_orange
            case 4:
                selectedItem = .fruit_strawberry
            default:
                scoreLabel.setText("ERROR 3C")
            }
        case .errorType:
            scoreLabel.setText("ERROR 3")
        }
        
        switch selectedItem {
        case .dot:
            selectedBox.setImage(UIImage(named: "dot"))
            selectedBoxImageName = "dot"
        case .dot_large:
            selectedBox.setImage(UIImage(named: "dot-large"))
            selectedBoxImageName = "dot-large"
        case .ghost_red:
            selectedBox.setImage(UIImage(named: "ghost-red"))
            selectedBoxImageName = "ghost"
        case .ghost_blue:
            selectedBox.setImage(UIImage(named: "ghost-blue"))
            selectedBoxImageName = "ghost"
        case .ghost_pink:
            selectedBox.setImage(UIImage(named: "ghost-pink"))
            selectedBoxImageName = "ghost-"
        case .ghost_orange:
            selectedBox.setImage(UIImage(named: "ghost-orange"))
            selectedBoxImageName = "ghost"
        case .fruit_apple:
            selectedBox.setImage(UIImage(named: "fruit-apple"))
            selectedBoxImageName = "fruit"
        case .fruit_cherry:
            selectedBox.setImage(UIImage(named: "fruit-cherry"))
            selectedBoxImageName = "fruit"
        case .fruit_orange:
            selectedBox.setImage(UIImage(named: "fruit-orange"))
            selectedBoxImageName = "fruit"
        case .fruit_strawberry:
            selectedBox.setImage(UIImage(named: "fruit-strawberry"))
            selectedBoxImageName = "fruit"
        case .errorType:
            scoreLabel.setText("ERROR 4")
        }
        
        return (selectedBox, selectedItem)
    }
    
    func checkPacManDirection(_ indexValue: Int) -> PacManCharacterDirection {
        switch indexValue {
        case 1:
            return .E
        case 2:
            return .SE
        case 3:
            return .S
        case 4:
            return .SW
        case 5:
            return .W
        case 6:
            return .NW
        case 7:
            return .N
        case 8:
            return .NE
        default:
            print("ERROR 5")
            return .errorType
        }
    }
    
    func checkPacManInteraction(_ direction: PacManCharacterDirection) -> PacManInteractionType {
        var boxToLookIn: WKInterfaceImage
        
        switch direction {
        case .E:
            boxToLookIn = box_centerright
        case .SE:
            boxToLookIn = box_bottomright
        case .S:
            boxToLookIn = box_bottomcenter
        case .SW:
            boxToLookIn = box_bottomleft
        case .W:
            boxToLookIn = box_centerleft
        case .NW:
            boxToLookIn = box_topleft
        case .N:
            boxToLookIn = box_topcenter
        case .NE:
            boxToLookIn = box_topright
        case .errorType:
            print("ERROR 6")
            return .errorType
        }
        
        switch selectedBoxImageName {
        case "dot":
            return .dotInteraction
        case "dot-large":
            return .largeDotInteraction
        case "fruit":
            return .fruitInteraction
        case "ghost":
            return .ghostInteraction
        default:
            print("ERROR 7")
            return .errorType
        }
    }
}

