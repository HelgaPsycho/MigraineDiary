//
//  ViewController.swift
//  MigraineDiary
//
//  Created by Ольга Егорова on 04.09.2022.
//

import UIKit

class FirstViewController: UIViewController {
    
    
    @IBOutlet weak var AppName: UILabel!
    
    let defaults = UserDefaults.standard

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        AppName.text = Keys.appName
        
    }
    
      
    @IBAction func settingsButton(_ sender: UIButton) {
        
        if UserSettings.language == nil {
            UserSettings.language = "rus"
        } else {
            if UserSettings.language == "rus" {
                UserSettings.language = "eng"
            }
            else { UserSettings.language = "rus" }
        }
        
        print(UserSettings.language)
        AppName.text = Keys.appName
        
    }
    
}

