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
        
    
   // let tableViewController = TableViewController(nibName: "ok1-8G-oqs-view-Ana-dm-MZo", bundle: .main)
    //let tableViewController = TableViewController()
   // let firstViewController = FirstViewController()
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
           //  tableViewController.printTestString()
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
            print("Duration of Migrain Episode 0 - 2 hours")
        }
        
        migraineEpisode.intensityAfterMadication = Int16(intensityAfterMedicationSegmantalController.selectedSegmentIndex + 1)
        
     dataStoreManager.saveContext()
        
        //=======================ДОБАВИТЬ ОБНОВЛЕНИЕ TABLEVIEWCONTROLLER===========================
        // не работает:
        //tableViewController.viewDidLoad()
        //   tableViewController.reloadInputViews()
        // tableViewController.viewWillAppear(true)
        //tableViewController.viewDidAppear(false)
        // СВОРАЧИВАНИЕ КОНТРОЛЛЕРА ПРИ НАЖАТИИ КНОПКИ SAVE
     self.dismiss(animated: true, completion: nil)
      //  tableViewController.dismiss(animated: true)
      //  firstViewController.dismiss(animated: false)
        //firstViewController.reloadInputViews()
       // tableViewController.loadView()
        
        
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

