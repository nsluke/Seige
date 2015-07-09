//
//  Projectile.swift
//  Seige
//
//  Created by Luke Solomon on 6/29/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import UIKit

class Projectile: CCNode {
   
    func launch(){
        physicsBody.velocity = ccp(1000, 0)

    }
    
    
    
    
}
