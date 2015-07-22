//
//  File.swift
//  Seige
//
//  Created by Luke Solomon on 7/22/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class GameOver : CCNode {
    
    weak var fireBallLabel: CCLabelTTF!
    
    func didLoadFromCCB () {
        
        fireBallLabel.string = "\(GameStateSingleton.sharedInstance.score) Fireballs"
        
    }
    
    
}