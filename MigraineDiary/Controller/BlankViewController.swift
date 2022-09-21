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
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var triggersTextField: UITextField!
    @IBOutlet weak var auraSegmentalController: UISegmentedControl!
    @IBOutlet weak var intensitySegmentalController: UISegmentedControl!
    @IBOutlet weak var medicationTextField: UITextField!
    @IBOutlet weak var durationSegmentalController: UISegmentedControl!
    @IBOutlet weak var intensityAfterMedicationSegmantalController: UISegmentedControl!
    
    let tableViewController = TableViewController(nibName: "tableViewController", bundle: .main)
    //@IBOutlet var migraineTableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("viewDidLoad called for BlankViewController")
        
    
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            print("viewWillAppear called for BlankViewController")
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            print ("viewDidAppear called for BlankViewController")
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            //вызывается при закрывании контроллера

            print ("viewWillDisppear for BlankViewController")
             //tableViewController.viewDidLoad()
             tableViewController.printTestString()
        }
        
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            print("viewDidDissapear for BlankViewController")
        }


    
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {

        let migraineEpisode = MigraineEpisode(context: dataStoreManager.blankViewContext)

        migraineEpisode.date = datePicker.date
        migraineEpisode.triggers = textFieldDidEndEditing(triggersTextField)
        if auraSegmentalController.selectedSegmentIndex == 0 {
            migraineEpisode.aura = false
        } else { migraineEpisode.aura = true }
        switch intensitySegmentalController.selectedSegmentIndex {
        case 0 :
            migraineEpisode.intensity = 1
        case 1 :
            migraineEpisode.intensity = 2
        case 2 :
            migraineEpisode.intensity = 3
        case 3 :
            migraineEpisode.intensity = 4
        case 4 :
            migraineEpisode.intensity = 5
        case 5 :
            migraineEpisode.intensity = 6
        case 6 :
            migraineEpisode.intensity = 7
        case 7 :
            migraineEpisode.intensity = 8
        case 8 :
            migraineEpisode.intensity = 9
        case 9 :
            migraineEpisode.intensity = 10
        default:
            migraineEpisode.intensity = 1
        }
        
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
            print("Duration of Migrain Episode 0 - 2 hours")
        }
        switch intensityAfterMedicationSegmantalController.selectedSegmentIndex {
        case 0 :
            migraineEpisode.intensityAfterMadication = 0
        case 1 :
            migraineEpisode.intensityAfterMadication = 1
        case 2 :
            migraineEpisode.intensityAfterMadication = 2
        case 3 :
            migraineEpisode.intensityAfterMadication = 3
        case 4 :
            migraineEpisode.intensityAfterMadication = 4
        case 5 :
            migraineEpisode.intensityAfterMadication = 5
        case 6 :
            migraineEpisode.intensityAfterMadication = 6
        case 7 :
            migraineEpisode.intensityAfterMadication = 7
        case 8 :
            migraineEpisode.intensityAfterMadication = 8
        case 9 :
            migraineEpisode.intensityAfterMadication = 9
        case 10 :
            migraineEpisode.intensityAfterMadication = 19
        default:
            migraineEpisode.intensityAfterMadication = 0
    
      }
        
     dataStoreManager.saveContext()
        
        //ДОБАВИТЬ ОБНОВЛЕНИЕ TABLEVIEWCONTROLLER
        
        // СВОРАЧИВАНИЕ КОНТРОЛЛЕРА ПРИ НАЖАТИИ КНОПКИ SAVE
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

