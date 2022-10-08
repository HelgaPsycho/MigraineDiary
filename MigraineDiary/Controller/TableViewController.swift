//
//  TableViewController.swift
//  MigraineDiary
//
//  Created by Ольга Егорова on 04.09.2022.
//

import UIKit
import CoreData


class TableViewController: UITableViewController, NSFetchedResultsControllerDelegate, Subscriber {
    
    var dataStoreManager = DataStoreManager()

    var migraineEpisodeArray: Array <MigraineEpisode> = []
    
    var selectedMigraineEpisode = MigraineEpisode ()
    
    @IBOutlet var migraineTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(MigraineEpisodeCell.nib(), forCellReuseIdentifier: MigraineEpisodeCell.identifier)
        
        do {
            migraineEpisodeArray = try toObtainAndSortMigrainEpisodes() }
        catch DataStoreManagerErrors.emptyDataBase {
            //ОБРАБОТКА ОШИБКИ
            // migraineEpisodeArray  = ячейка 
        }
        catch {
        }
        dataStoreManager.subscribe(subscriber: self)

    }
    
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
            let indexOfArrayElement: Int = Int(indexPath.row)
            do {
               try dataStoreManager.obtainAndRemoveOneMigraineEpisode (date: migraineEpisodeArray[indexOfArrayElement].date!)
                //print ("\(migraineEpisodeArray[].date!)")
            }
            catch {print ("ERROR in TablieViewController with cell delete")}
           
            self.migraineEpisodeArray.remove(at: indexOfArrayElement)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
           
            }
            
        }
    
    //ПЕРЕХОД ИЗ ЯЧЕЙКИ НА КОНТРОЛЛЕР С РАЗВЕРНУТОЙ ИНФОРМАЦИЕЙ ОБ ЭПИЗОДЕ МИГРЕНИ
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do {
            selectedMigraineEpisode = try dataStoreManager.obtainOneMigraineEpisode(date: migraineEpisodeArray[indexPath.row].date!)
        }
        catch {
            print ("ERROR in TablieViewController with find migraine episode")
        }
        print (selectedMigraineEpisode)
        self.performSegue(withIdentifier: "segueToInformationViewController", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)


    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("================prepareForeSegue=========================")
        print (selectedMigraineEpisode)
        if segue.identifier == "segueToInformationViewController" {
            let destinationVC = segue.destination as! InformationViewController
            destinationVC.migraineEpisode = selectedMigraineEpisode

        
        }
    }
    
    
    func loadData (){
       
        tableView.register(MigraineEpisodeCell.nib(), forCellReuseIdentifier: MigraineEpisodeCell.identifier)
        
        do { self.migraineEpisodeArray = try toObtainAndSortMigrainEpisodes()}
        catch { return}
        
        DispatchQueue.main.async {
            self.migraineTableView.reloadData()
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


// MARK: - PATTERN OBSERVER
    
    func update() {
        loadData()
    
        
        
}
}
