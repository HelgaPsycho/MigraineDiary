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
    

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var triggerLabel: UILabel!
    
    @IBOutlet weak var auraLabel: UILabel!
    
    @IBOutlet weak var intensityLabel: UILabel!
    @IBOutlet weak var intensityView: UIImageView!
    
    @IBOutlet weak var medicationLabel: UILabel!
    
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var intensityAfterMedicationLabel: UILabel!
    
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
        
        let presenter = InformationViewControllerPresenter (migraineEpisode: migraineEpisode)
        
        titleLabel.text = presenter.title
        dateLabel.text = presenter.dateLabelText
        triggerLabel.text = presenter.triggersLabelText
        auraLabel.text = presenter.auraLabelText
        intensityLabel.text = presenter.intensityLabelText
        intensityView.image = presenter.intensityView
        medicationLabel.text = presenter.medicationLabelText
        durationLabel.text = presenter.durationLabelText
        intensityAfterMedicationLabel.text = presenter.intensityAfterMedicationLabelText
        intensityAfterMedicationView.image = presenter.intensityAfterMedicationView
        
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


