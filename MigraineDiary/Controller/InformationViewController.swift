//
//  InformationViewController.swift
//  MigraineDiary
//
//  Created by Ольга Егорова on 05.10.2022.
//

import UIKit

class InformationViewController: UIViewController {
    
    var selectedMigrainEpisode: MigraineEpisode?

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var triggerLabel: UILabel!
    
    @IBOutlet weak var auraLabel: UILabel!
    
    @IBOutlet weak var intevsityView: UIImageView!
    
    @IBOutlet weak var medicationView: UILabel!
    
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var intensityAfterMaedicationView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print (selectedMigrainEpisode)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeButtonPressed(_ sender: UIButton) {
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
