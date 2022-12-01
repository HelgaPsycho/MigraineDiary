//
//  ViewController.swift
//  MigraineDiary
//
//  Created by Ольга Егорова on 04.09.2022.
//

import UIKit

class FirstViewController: UIViewController {


    var dataStoreManager = DataStoreManager()
    var migraineEpisodeArray: Array <MigraineEpisode> = []
    var selectedMigraineEpisode = MigraineEpisode ()
    
    let defaults = UserDefaults.standard
    
    let verticalStackView: UIStackView = {
          let stackView = UIStackView()
          stackView.translatesAutoresizingMaskIntoConstraints = false
          stackView.axis = .vertical
          stackView.distribution = .fillEqually
          stackView.alignment = .center
          stackView.spacing = 0
      
          return stackView
      }()
    
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var appNameView: UIView!
    @IBOutlet weak var tableViewContainer: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    var tableView: UITableView = {
            let tableView = UITableView ()
        tableView.backgroundColor = .yellow
            tableView.translatesAutoresizingMaskIntoConstraints = false
        print ("tableView initilized")
            return tableView
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        view.addSubview(tableViewContainer)
        tableViewContainer.addSubview(tableView)
        tableViewContainer.addSubview(appNameView)
        appNameView.addSubview(appName)
        appName.text = Keys.appName
        view.addSubview(bottomView)
        setupTableView()
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
       
    
func toObtainAndSortMigrainEpisodes () throws -> [MigraineEpisode] {
    if var migraineEpisodeArray = try? dataStoreManager.obtainMigraineEpisode() {
        migraineEpisodeArray.sort {$0.date! > $1.date!}
        return migraineEpisodeArray
    } else {
        throw DataStoreManagerErrors.emptyDataBase }
}
    
    func setupTableView (){
            tableView.topAnchor.constraint(equalTo: appNameView.bottomAnchor, constant: 2).isActive = true
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
            tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        
    
    
        }
    
      
    @IBAction func settingsButton(_ sender: UIButton) {
        
        let alert = UIAlertController(title: Keys.languageAlerMassage, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Русский", style: .default, handler: { (UIAlertAction) in UserSettings.language = "rus"; self.appName.text = Keys.appName}))
        alert.addAction(UIAlertAction(title: "English", style: .default, handler: { (UIAlertAction) in UserSettings.language = "eng"; self.appName.text = Keys.appName}))
        
        present(alert, animated: true, completion: nil)
        
//        if UserSettings.language == nil {
//            UserSettings.language = "rus"
//        } else {
//            if UserSettings.language == "rus" {
//                UserSettings.language = "eng"
//            }
//            else { UserSettings.language = "rus" }
//        }
//
//        print(UserSettings.language)
      //  AppName.text = Keys.appName
        
    }
    
}

extension FirstViewController: UITableViewDelegate {
    
}

// MARK: - Table view data source

extension FirstViewController: UITableViewDataSource {
    

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return migraineEpisodeArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = tableView.dequeueReusableCell(withIdentifier: MigraineEpisodeCell.identifier, for: indexPath) as! MigraineEpisodeCell
        let score = migraineEpisodeArray[indexPath.row].intensity
        let date = migraineEpisodeArray[indexPath.row].date
        let medication = migraineEpisodeArray[indexPath.row].medication
        let image: UIImage = UIImage(imageLiteralResourceName: "\(score)")
        customCell.configure(date: date!, medication: medication!, image: image)
        //cell.textLabel?.text = "22.03.22"
        
        return customCell
        
    }
    
    
}

extension FirstViewController: Subscriber {
    func update() {
        loadData()
    }
    
    func loadData (){
       
        tableView.register(MigraineEpisodeCell.nib(), forCellReuseIdentifier: MigraineEpisodeCell.identifier)
        
        do { self.migraineEpisodeArray = try toObtainAndSortMigrainEpisodes()}
        catch { return}
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
       
        

        
    }
}
    
