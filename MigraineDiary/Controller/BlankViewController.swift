//
//  BlankViewController.swift
//  MigraineDiary
//
//  Created by Ольга Егорова on 06.09.2022.
//

import UIKit
import CoreData

class BlankViewController: UIViewController {
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var triggersTextField: UITextField!
    @IBOutlet weak var auraSegmentalController: UISegmentedControl!
    @IBOutlet weak var intensitySegmentalController: UISegmentedControl!
    @IBOutlet weak var medicationTextField: UITextField!
    @IBOutlet weak var durationSegmentalController: UISegmentedControl!
    @IBOutlet weak var intensityAfterMedicationSegmantalController: UISegmentedControl!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //let medicationMenu = UIMenu (title: "Medication", children: medicationMenuActions)
    //   medicationButton.menu = medicationMenu
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        print("Migraine date is \(datePicker.date)")
        print("Migrain trigger is \(String(describing: triggersTextField.text))")
        if auraSegmentalController.selectedSegmentIndex == 0 {
            print ("No Aura")
        } else if auraSegmentalController.selectedSegmentIndex == 1 { print ("With Aura") }
        switch intensitySegmentalController.selectedSegmentIndex {
        case 0 :
            print("Intensity of the migraine is 1")
        case 1 :
            print("Intensity of the migraine is 2")
        case 2 :
            print("Intensity of the migraine is 3")
        case 3 :
            print("Intensity of the migraine is 4")
        case 4 :
            print("Intensity of the migraine is 5")
        case 5 :
            print("Intensity of the migraine is 6")
        case 6 :
            print("Intensity of the migraine is 7")
        case 7 :
            print("Intensity of the migraine is 8")
        case 8 :
            print("Intensity of the migraine is 9")
        case 9 :
            print("Intensity of the migraine is 10")
        default:
            print("Intensity of the migraine is 1")
        }
        print("Medication is \(String(describing: medicationTextField.text))")
        switch durationSegmentalController.selectedSegmentIndex {
        case 0 :
            print("Duration of Migrain Episode is 0 - 2 hours ")
        case 1 :
            print("Duration of Migrain Episode is 2 - 6 hours")
        case 2 :
            print("Duration of Migrain Episode is 6 - 12 hours")
        case 3 :
            print("Duration of Migrain Episode > 12 hours")
        case 4 :
            print("Duration of Migrain Episode > 24 hours")
        default:
            print("Duration of Migrain Episode 0 - 2 hours")
        }
        switch intensityAfterMedicationSegmantalController.selectedSegmentIndex {
        case 0 :
            print("Intensity of the migraine after medication is 1")
        case 1 :
            print("Intensity of the migraine after medication is 2")
        case 2 :
            print("Intensity of the migraine after medication is 3")
        case 3 :
            print("Intensity of the migraine after medication is 4")
        case 4 :
            print("Intensity of the migraine after medication is 5")
        case 5 :
            print("Intensity of the migraine after medication is 6")
        case 6 :
            print("Intensity of the migraine after medication is 7")
        case 7 :
            print("Intensity of the migraine after medication is 8")
        case 8 :
            print("Intensity of the migraine after medication is 9")
        case 9 :
            print("Intensity of the migraine after medication is 10")
        default:
            print("Intensity of the migraine after medication is 1")
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
}
