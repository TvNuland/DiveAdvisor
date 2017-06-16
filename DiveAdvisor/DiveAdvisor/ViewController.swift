//
//  ViewController.swift
//  DiveAdvisor
//
//  Created by ben smith on 14/06/17.
//  Copyright © 2017 ben smith. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DAServiceClass.diveSearchByCoords()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

