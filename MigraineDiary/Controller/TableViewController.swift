//
//  TableViewController.swift
//  MigraineDiary
//
//  Created by Ольга Егорова on 04.09.2022.
//

import UIKit
import CoreData

class TableViewController: UITableViewController, NSFetchedResultsControllerDelegate   {
    
    var dataStoreManager = DataStoreManager()
    
    var migraineEpisodeArray: Array <MigraineEpisode> = []
    
    @IBOutlet var migraineTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        migraineTableView.register(MigraineEpisodeCell.nib(), forCellReuseIdentifier: MigraineEpisodeCell.identifier)
        
        do {
            migraineEpisodeArray = try toObtainAndSortMigrainEpisodes() }
        catch DataStoreManagerErrors.emptyDataBase {
            //ОБРАБОТКА ОШИБКИ
            // migraineEpisodeArray  = ячейка 
        }
        catch {
        }
        
        print("viewDidLoad called for TableViewController")

    }
    //метод для проверки, можно ли вызвать функцию с tableViewController при закрывании blancViewController
    func printTestString () {
        print ("TalbleViewController called throw blankViewController")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            print("viewWillAppear called for TableViewController")
        }
            
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           print ("viewDidAppear called for TableViewController")
       }
       
       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           print ("viewWillDisppear for TableViewController")
       }
       
       override func viewDidDisappear(_ animated: Bool) {
           super.viewDidDisappear(animated)
           print("viewDidDissapear for TableViewController")
       }

    //        migrainScaleArray = [10, 3, 6, 9 ,2]
    //        migraineTableView.dataSource = self
    //        migraineTableView.delegate = self
    //
    
    //migraineTableView.register(MigraineEpisodeCell.self, forCellReuseIdentifier: "reuseIdentifier")
    
    // Uncomment the following line to preserve selection between presentations
    //self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return migraineEpisodeArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = migraineTableView.dequeueReusableCell(withIdentifier: MigraineEpisodeCell.identifier, for: indexPath) as! MigraineEpisodeCell
        let score = migraineEpisodeArray[indexPath.row].intensity
        let date = migraineEpisodeArray[indexPath.row].date
        let medication = migraineEpisodeArray[indexPath.row].medication
        let image: UIImage = UIImage(imageLiteralResourceName: "\(score)")
        customCell.configure(date: date!, medication: medication!, image: image)
        //cell.textLabel?.text = "22.03.22"
        
        return customCell
        
    }
    
//    func formateDateToString (date: Date) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
//        let formatedDate = dateFormatter.string(from: date)
//        return formatedDate

    
    func toObtainAndSortMigrainEpisodes () throws -> [MigraineEpisode] {
        if var migraineEpisodeArray = try? dataStoreManager.obtainMigraineEpisode() {
            migraineEpisodeArray.sort {$0.date! > $1.date!}
            return migraineEpisodeArray
        } else {
            throw DataStoreManagerErrors.emptyDataBase }
    }
    
//УДАЛЕНИЕ ЯЧЕЙКИ
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.migraineEpisodeArray.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            let indexOfArrayElement: Int = Int(indexPath.row) - 1
            do {
               try dataStoreManager.obtainAndRemoveOneMigraineEpisode (date: migraineEpisodeArray[indexOfArrayElement].date!)
                //print ("\(migraineEpisodeArray[].date!)")
            }
            catch {print ("ERROR in TablieViewController with cell delete")}
           

            //dataStoreManager.removeMigraineEpisode(migraineEpisode: <#T##MigraineEpisode#>)
            //migraineEpisodeArray[indexPath]
//            let migraineEpisodeCell = tableView.dequeueReusableCell(withIdentifier: "migraineEpisodeCell", for: indexPath) as! MigraineEpisodeCell
//                for migraineEpisode in migraineEpisodeArray {
                  //  if migraineEpisodeCell.formateDateToString(date: migraineEpisode.date ?? //Date(timeIntervalSinceNow: 0) == migraineEpisodeCell.dateLabel)
                  //  do {
                    //dataStoreManager.removeMigraineEpisode(migraineEpisode: migraineEpisode)
               // }
            }
            
        }
    }

/*
 // Override to support conditional editing of the table view.
 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the specified item to be editable.
 return true
 }
 */

/*
 // Override to support editing the table view.
 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
 if editingStyle == .delete {
 // Delete the row from the data source
 tableView.deleteRows(at: [indexPath], with: .fade)
 } else if editingStyle == .insert {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
 
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


