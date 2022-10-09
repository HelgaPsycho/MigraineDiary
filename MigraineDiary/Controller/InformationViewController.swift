//
//  InformationViewController.swift
//  MigraineDiary
//
//  Created by Ольга Егорова on 05.10.2022.
//

import UIKit

class InformationViewController: UIViewController, Subscriber {
        
    var migraineEpisode: MigraineEpisode!
    
    var dataStoreManager: DataStoreManager!
    

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var triggerLabel: UILabel!
    
    @IBOutlet weak var auraLabel: UILabel!
    
    @IBOutlet weak var intensityView: UIImageView!
    
    @IBOutlet weak var medicationLabel: UILabel!
    
    @IBOutlet weak var durationLabel: UILabel!

    @IBOutlet weak var intensityAfterMedicationView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataStoreManager.subscribe(subscriber: self)
        
         getOutletsValue()
         
    }
    
    
    @IBAction func changeButtonPressed(_ sender: UIButton) {
        
    }
    
    func formateDateToString (date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        let formatedDate = dateFormatter.string(from: date)
        return formatedDate
    }
    
    func getOutletsValue () {
        dateLabel.text = "Date: \(formateDateToString(date: migraineEpisode.date!))"
        
        var triggers: String
        if migraineEpisode.triggers == "" {
            triggers = "No"
        }  else {
            triggers = migraineEpisode.triggers!
        }
        triggerLabel.text = "Triggers: \(triggers)"
        
        let aura: String = migraineEpisode.aura ? "Yes" : "No"
        auraLabel.text = "Aura: \(aura)"
        
        intensityView.image = UIImage(imageLiteralResourceName: "\(migraineEpisode!.intensity)")
        
        var medication: String
        if migraineEpisode.medication == "" {
            medication = "No"
        }  else {
            medication = migraineEpisode.medication!
        }
        medicationLabel.text = "Medication: \(medication)"
        
        durationLabel.text = "Duration: \(migraineEpisode.dutation!) hours"
        
        intensityAfterMedicationView.image = UIImage(imageLiteralResourceName: "\(migraineEpisode!.intensityAfterMadication)")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeBlankSegue" {
            let destinationVC = segue.destination as! ChangeBlankViewController
            destinationVC.migraineEpisode = migraineEpisode
            destinationVC.dataStoreManager = dataStoreManager

        
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func update() {
        
        getOutletsValue()
    
    }
    
    
}


