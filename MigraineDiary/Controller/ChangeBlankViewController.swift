//
//  ChangeBlankViewController.swift
//  MigraineDiary
//
//  Created by Ольга Егорова on 06.10.2022.
//

import UIKit

class ChangeBlankViewController: UIViewController {

    var migraineEpisode: MigraineEpisode?
    var dataStoreManager: DataStoreManager?
    
    @IBOutlet weak var migraineEpisodeBlankTitle: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var triggerLabel: UILabel!
    @IBOutlet weak var triggersLabel: UITextField!
    @IBOutlet weak var auraSegmentedControl: UISegmentedControl!
    @IBOutlet weak var intensityLabel: UILabel!
    @IBOutlet weak var intensitySegmentalControl: UISegmentedControl!
    @IBOutlet weak var medicationLabel: UILabel!
    @IBOutlet weak var medicationTextField: UITextField!
    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var durationSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var intensityAfterMedicationLabel: UILabel!
    @IBOutlet weak var intensityAfterMedicationSegmentalControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInitialValues()
        let presenter = BlankViewControllerPresenter()
        
        migraineEpisodeBlankTitle.text = presenter.migrainEpisodeBlank
        triggerLabel.text = presenter.triggers
        
        let noAuraString: String = presenter.noAura
        let auraString: String = presenter.withAura
        auraSegmentedControl.setTitle(noAuraString, forSegmentAt: 0)
        auraSegmentedControl.setTitle(auraString, forSegmentAt: 1)
        intensityLabel.text = presenter.intensity
        medicationLabel.text = presenter.medication
        durationLabel.text = presenter.durationInHours
        intensityAfterMedicationLabel.text = presenter.intensityAfterMedication
        
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
        guard let selectMigrainEpiside = migraineEpisode else {
            print("No Migrain Episode Find")
            return
        }
        datePicker.date = selectMigrainEpiside.date
        triggersLabel.text = selectMigrainEpiside.triggers!
        if selectMigrainEpiside.aura == true {
        auraSegmentedControl.selectedSegmentIndex = 1
        } else {
            auraSegmentedControl.selectedSegmentIndex = 0
        }
        intensitySegmentalControl.selectedSegmentIndex = Int(selectMigrainEpiside.intensity - 1)
        medicationTextField.text = selectMigrainEpiside.medication!
        switch selectMigrainEpiside.dutation{
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
        intensityAfterMedicationSegmentalControl.selectedSegmentIndex = Int(selectMigrainEpiside.intensityAfterMadication - 1)
        
        
    }

    
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        guard let selectMigrainEpisode =  migraineEpisode else {print("No Migrain Episode Find")
            return}
        
        selectMigrainEpisode.setValue(datePicker.date, forKey: #keyPath(MigraineEpisode.date))
        
        selectMigrainEpisode.setValue(textFieldDidEndEditing(triggersLabel), forKey: #keyPath(MigraineEpisode.triggers))
        
      if auraSegmentedControl.selectedSegmentIndex == 0 {
          selectMigrainEpisode.setValue(false, forKey: #keyPath(MigraineEpisode.aura))
        } else { selectMigrainEpisode.setValue(true, forKey: #keyPath(MigraineEpisode.aura)) }
        
        selectMigrainEpisode.setValue(Int16(intensitySegmentalControl.selectedSegmentIndex + 1), forKey: #keyPath(MigraineEpisode.intensity))
        
        selectMigrainEpisode.setValue(textFieldDidEndEditing(medicationTextField), forKey: #keyPath(MigraineEpisode.medication))
        
        switch durationSegmentedControl.selectedSegmentIndex {
        case 0 :
            selectMigrainEpisode.setValue("0 - 2", forKey: #keyPath(MigraineEpisode.dutation))
        case 1 :
            selectMigrainEpisode.setValue("2 - 6", forKey: #keyPath(MigraineEpisode.dutation))
        case 2 :
            selectMigrainEpisode.setValue("6 - 12", forKey: #keyPath(MigraineEpisode.dutation))
        case 3 :
            selectMigrainEpisode.setValue("12 - 24", forKey: #keyPath(MigraineEpisode.dutation))
        case 4 :
            selectMigrainEpisode.setValue("> 24", forKey: #keyPath(MigraineEpisode.dutation))
        default:
            print("Duration of Migrain Episode 0 - 2 hours")
        }

        selectMigrainEpisode.setValue(intensityAfterMedicationSegmentalControl.selectedSegmentIndex + 1,
 forKey: #keyPath(MigraineEpisode.intensityAfterMadication))
    
        guard let dsManager = dataStoreManager else {
            print("No dataStoreManager find")
            return
        }

        dsManager.saveContext()
        dsManager.notifySuscribers ()
        
       // dataStoreManager.updateMigraineEpisode(migraineEpisode: migraineEpisode)
    
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ChangeBlankViewController: UITextFieldDelegate {
    private func textFieldDidEndEditing(_ textField: UITextField) -> String {
        return textField.text!
    }
    

}


    
