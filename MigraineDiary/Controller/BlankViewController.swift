//
//  BlankViewController.swift
//  MigraineDiary
//
//  Created by Ольга Егорова on 06.09.2022.
//

import UIKit
import CoreData

class BlankViewController: UIViewController {
    
    var dataStoreManager = DataStoreManager()
    
    
    @IBOutlet weak var migraineEpisodeBlankTitle: UILabel!
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    

    @IBOutlet weak var triggerLabel: UILabel!
    @IBOutlet weak var triggersTextField: UITextField!
    @IBOutlet weak var auraSegmentalController: UISegmentedControl!
    @IBOutlet weak var intensityLabel: UILabel!
    @IBOutlet weak var intensitySegmentalController: UISegmentedControl!
    
    @IBOutlet weak var medicationLabel: UILabel!
    @IBOutlet weak var medicationTextField: UITextField!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var durationSegmentalController: UISegmentedControl!
    @IBOutlet weak var intensityAfterMedicationLabel: UILabel!
    @IBOutlet weak var intensityAfterMedicationSegmantalController: UISegmentedControl!
        
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        let presenter = BlankViewControllerPresenter()
        
        migraineEpisodeBlankTitle.text = presenter.migrainEpisodeBlank
        triggerLabel.text = presenter.triggers
        
        let noAuraString: String = presenter.noAura
        let auraString: String = presenter.withAura
        auraSegmentalController.setTitle(noAuraString, forSegmentAt: 0)
        auraSegmentalController.setTitle(auraString, forSegmentAt: 1)
        intensityLabel.text = presenter.intensity
        medicationLabel.text = presenter.medication
        durationLabel.text = presenter.durationInHours
        intensityAfterMedicationLabel.text = presenter.intensityAfterMedication
        
        
       // auraSegmentalController.titleForSegment(at: 1) = auraString
        
        
        // Do any additional setup after loading the view.
    }
   
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {

        let migraineEpisode = MigraineEpisode(context: dataStoreManager.blankViewContext)

        migraineEpisode.date = datePicker.date
        migraineEpisode.triggers = textFieldDidEndEditing(triggersTextField)
        if auraSegmentalController.selectedSegmentIndex == 0 {
            migraineEpisode.aura = false
        } else { migraineEpisode.aura = true }
//
        migraineEpisode.intensity = Int16(intensitySegmentalController.selectedSegmentIndex + 1)
        
        migraineEpisode.medication = textFieldDidEndEditing(medicationTextField)
    
        switch durationSegmentalController.selectedSegmentIndex {
        case 0 :
            migraineEpisode.dutation = "0 - 2"
        case 1 :
            migraineEpisode.dutation = "2 - 6"
        case 2 :
            migraineEpisode.dutation = "6 - 12"
        case 3 :
            migraineEpisode.dutation = "12 - 24"
        case 4 :
            migraineEpisode.dutation = "> 24"
        default:
            migraineEpisode.dutation = "0 - 2"
        }
        
        migraineEpisode.intensityAfterMadication = Int16(intensityAfterMedicationSegmantalController.selectedSegmentIndex + 1)
        
     dataStoreManager.saveContext()
        
     self.dismiss(animated: true, completion: nil)
     
//
//        /*
//         // MARK: - Navigation
//
//         // In a storyboard-based application, you will often want to do a little preparation before navigation
//         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         // Get the new view controller using segue.destination.
//         // Pass the selected object to the new view controller.
//         }
//         */
   }
    
}

extension BlankViewController: UITextFieldDelegate {
    private func textFieldDidEndEditing(_ textField: UITextField) -> String {
        return textField.text!
    }
    

}

