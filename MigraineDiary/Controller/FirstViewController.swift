//
//  ViewController.swift
//  MigraineDiary
//
//  Created by Ольга Егорова on 04.09.2022.
//

import UIKit

class FirstViewController: UIViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad called for FirstViewController")
        // Do any additional setup after loading the view.
        
    }
    
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            print("viewWillAppear called for FirstViewController")
        }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print ("viewDidAppear called for FirstVC")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print ("viewWillDisppear for FirstVC")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDissapear for FirstVC")
    }

}

