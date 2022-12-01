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
        stackView.backgroundColor = .lightGray
          stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 0
          return stackView
      }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .blue
        label.font = UIFont(name: "Helvetica", size: 30)
        label.text = Keys.appTitle
        return label
    }()
    
    var tableView: UITableView = {
            let tableView = UITableView ()
        tableView.backgroundColor = .yellow
            tableView.translatesAutoresizingMaskIntoConstraints = false
        print ("tableView initilized")
            return tableView
        }()
    
    
    
//    @IBOutlet weak var appName: UILabel!
//    @IBOutlet weak var appNameView: UIView!
//    @IBOutlet weak var tableViewContainer: UIView!
//    @IBOutlet weak var bottomView: UIView!
//

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        view.addSubview(verticalStackView)
        setupVerticalSackView()
        
//        view.addSubview(tableViewContainer)
//        tableViewContainer.addSubview(tableView)
//        tableViewContainer.addSubview(appNameView)
//        appNameView.addSubview(appName)
//        appName.text = Keys.appTitle
//        view.addSubview(bottomView)
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
       
    
    func setupVerticalSackView (){
        
        
        verticalStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
                //почему-то top далеко от края safeArea
        verticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        verticalStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(tableView)
        
    }
    
    
func toObtainAndSortMigrainEpisodes () throws -> [MigraineEpisode] {
    if var migraineEpisodeArray = try? dataStoreManager.obtainMigraineEpisode() {
        migraineEpisodeArray.sort {$0.date! > $1.date!}
        return migraineEpisodeArray
    } else {
        throw DataStoreManagerErrors.emptyDataBase }
}
    
    func setupTableView (){
            tableView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
            tableView.bottomAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
    
    
        }
    
      
    @IBAction func settingsButton(_ sender: UIButton) {
        
        let alert = UIAlertController(title: Keys.languageAlerMassage, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Русский", style: .default, handler: { (UIAlertAction) in UserSettings.language = "rus"; self.titleLabel.text = Keys.appTitle}))
        alert.addAction(UIAlertAction(title: "English", style: .default, handler: { (UIAlertAction) in UserSettings.language = "eng"; self.titleLabel.text = Keys.appTitle}))

        present(alert, animated: true, completion: nil)
//
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
    
