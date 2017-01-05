//
//  SetupViewController.swift
//  CarMusicPlayer
//
//  Created by Umar Haroon on 1/4/17.
//  Copyright © 2017 Umar Haroon. All rights reserved.
//

import Foundation
import UIKit

class SetupViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func tryAuthorizingOnButtonPress(_ sender: UIButton) {
        print("pressed")
        let j = MusicLibrary()
        j.authorize()
        print(j.authorize())
        //TODO: Make this work.

    }
    
}
