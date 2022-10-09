//
//  ChangeBlankViewController.swift
//  MigraineDiary
//
//  Created by Ольга Егорова on 06.10.2022.
//

import UIKit

class ChangeBlankViewController: UIViewController {

    var migraineEpisode: MigraineEpisode!
    var dataStoreManager: DataStoreManager!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var triggersLabel: UITextField!
    @IBOutlet weak var auraSegmentedControl: UISegmentedControl!
    @IBOutlet weak var intensitySegmentalControl: UISegmentedControl!
    @IBOutlet weak var medicationTextField: UITextField!
    @IBOutlet weak var durationSegmentedControl: UISegmentedControl!
    @IBOutlet weak var intensityAfterMedicationSegmentalControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInitialValues()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    func getInitialValues () {
        datePicker.date = migraineEpisode.date!
        triggersLabel.text = migraineEpisode.triggers!
        if migraineEpisode.aura == true {
        auraSegmentedControl.selectedSegmentIndex = 1
        } else {
            auraSegmentedControl.selectedSegmentIndex = 0
        }
        intensitySegmentalControl.selectedSegmentIndex = Int(migraineEpisode.intensity - 1)
        medicationTextField.text = migraineEpisode.medication!
        switch migraineEpisode.dutation{
        case "0 - 2" :
            durationSegmentedControl.selectedSegmentIndex = 0
        case  "2 - 6":
            durationSegmentedControl.selectedSegmentIndex = 1
        case "6 - 12" :
            durationSegmentedControl.selectedSegmentIndex = 2
        case "12 - 24" :
            durationSegmentedControl.selectedSegmentIndex = 3
        case "> 24" :
            durationSegmentedControl.selectedSegmentIndex = 4
        default:
            durationSegmentedControl.selectedSegmentIndex = 0
        }
        intensityAfterMedicationSegmentalControl.selectedSegmentIndex = Int(migraineEpisode.intensityAfterMadication - 1)
        
        
    }

    
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        migraineEpisode.setValue(datePicker.date, forKey: #keyPath(MigraineEpisode.date))
        
        migraineEpisode.setValue(textFieldDidEndEditing(triggersLabel), forKey: #keyPath(MigraineEpisode.triggers))
        
      if auraSegmentedControl.selectedSegmentIndex == 0 {
          migraineEpisode.setValue(false, forKey: #keyPath(MigraineEpisode.aura))
        } else { migraineEpisode.setValue(true, forKey: #keyPath(MigraineEpisode.aura)) }
        
        migraineEpisode.setValue(Int16(intensitySegmentalControl.selectedSegmentIndex + 1), forKey: #keyPath(MigraineEpisode.intensity))
        
        migraineEpisode.setValue(textFieldDidEndEditing(medicationTextField), forKey: #keyPath(MigraineEpisode.medication))
        
        switch durationSegmentedControl.selectedSegmentIndex {
        case 0 :
            migraineEpisode.setValue("0 - 2", forKey: #keyPath(MigraineEpisode.dutation))
        case 1 :
            migraineEpisode.setValue("2 - 6", forKey: #keyPath(MigraineEpisode.dutation))
        case 2 :
            migraineEpisode.setValue("6 - 12", forKey: #keyPath(MigraineEpisode.dutation))
        case 3 :
            migraineEpisode.setValue("12 - 24", forKey: #keyPath(MigraineEpisode.dutation))
        case 4 :
            migraineEpisode.setValue("> 24", forKey: #keyPath(MigraineEpisode.dutation))
        default:
            print("Duration of Migrain Episode 0 - 2 hours")
        }

        migraineEpisode.setValue(intensityAfterMedicationSegmentalControl.selectedSegmentIndex + 1,
 forKey: #keyPath(MigraineEpisode.intensityAfterMadication))
    

        dataStoreManager.saveContext()        
        dataStoreManager.notifySuscribers ()
        
       // dataStoreManager.updateMigraineEpisode(migraineEpisode: migraineEpisode)
    
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ChangeBlankViewController: UITextFieldDelegate {
    private func textFieldDidEndEditing(_ textField: UITextField) -> String {
        return textField.text!
    }
    

}


    
