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
    
    
    var upperView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillEqually
        view.alignment = .center
        return view
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .systemBlue
        label.font = UIFont(name: "Helvetica", size: 32)
        label.text = Keys.appTitle
        return label
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView ()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    var settingsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "gearshape.2")
        image!.withTintColor(.blue)
        button.setImage(image, for: .normal)
        var config = UIButton.Configuration.plain()
        button.configuration = config
        button.addTarget(self, action: #selector(settingsButtonPressed), for: .touchUpInside)
        return button
    }()
    
    var  plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "plus.app")
        image!.withTintColor(.blue)
        button.setImage(image, for: .normal)
        var config = UIButton.Configuration.plain()
        button.configuration = config
        button.addTarget(self, action: #selector(plusButtonPressed), for: .touchUpInside)
        return button
    }()
    
    var statisticButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "doc.text")
        image!.withTintColor(.blue)
        button.setImage(image, for: .normal)
        var config = UIButton.Configuration.plain()
        button.configuration = config
        return button
    }()
    
    //    @IBOutlet weak var appName: UILabel!
    //    @IBOutlet weak var appNameView: UIView!
    //    @IBOutlet weak var tableViewContainer: UIView!
    //    @IBOutlet weak var bottomView: UIView!
    //
    
    
    //MARK: - viewDidLoad
    
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
        
        tableView.dataSource = self
        tableView.delegate = self
    
        view.addSubview(upperView)
        setupUpperView()
        view.addSubview(bottomStackView)
        setupBottomStackView()
        
        view.addSubview(tableView)
        setupTableView()
        
        dataStoreManager.subscribe(subscriber: self)
    }
    
    func setupUpperView (){
        upperView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        upperView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        upperView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        upperView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/12).isActive = true
        
        upperView.addArrangedSubview(titleLabel)
        setupTitleLabel()
        
    }
    
    func setupTitleLabel (){
        
        titleLabel.bottomAnchor.constraint(equalTo: upperView.bottomAnchor, constant: 30).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: upperView.leftAnchor, constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: upperView.rightAnchor, constant: -20).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: upperView.heightAnchor, multiplier: 2/3).isActive = true
        
    }
    
    func setupTableView() {
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: upperView.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomStackView.topAnchor).isActive = true
        
        
        
    }
    
    
    func setupBottomStackView() {
        bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        bottomStackView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bottomStackView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bottomStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/12).isActive = true
        
        bottomStackView.addArrangedSubview(settingsButton)
        bottomStackView.addArrangedSubview(plusButton)
        bottomStackView.addArrangedSubview(statisticButton)
    }
    
    
    func toObtainAndSortMigrainEpisodes () throws -> [MigraineEpisode] {
        if var migraineEpisodeArray = try? dataStoreManager.obtainMigraineEpisode() {
            migraineEpisodeArray.sort {$0.date! > $1.date!}
            return migraineEpisodeArray
        } else {
            throw DataStoreManagerErrors.emptyDataBase }
    }
    
    //MARK: - Buttons Actions
    
    @objc func settingsButtonPressed(sender: UIButton!){
        let alert = UIAlertController(title: Keys.languageAlerMassage, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Русский", style: .default, handler: { (UIAlertAction) in UserSettings.language = "rus"; self.titleLabel.text = Keys.appTitle}))
        alert.addAction(UIAlertAction(title: "English", style: .default, handler: { (UIAlertAction) in UserSettings.language = "eng"; self.titleLabel.text = Keys.appTitle}))
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func plusButtonPressed(sender: UIButton!){
        self.performSegue(withIdentifier: "toMigraineEpisodeBlankSegue", sender: self)
       
    }

    
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
        guard let customCell = tableView.dequeueReusableCell(withIdentifier: MigraineEpisodeCell.identifier, for: indexPath) as? MigraineEpisodeCell else {fatalError("could not dequeueReusableCell")}
        let score = migraineEpisodeArray[indexPath.row].intensity
        let date = migraineEpisodeArray[indexPath.row].date
        let medication = migraineEpisodeArray[indexPath.row].medication
        let image: UIImage = UIImage(imageLiteralResourceName: "\(score)")
        customCell.configure(date: date!, medication: medication!, image: image)
        //cell.textLabel?.text = "22.03.22"
        
        return customCell
        
    }
    
}

extension FirstViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select row at called")
        do {
            selectedMigraineEpisode = try dataStoreManager.obtainOneMigraineEpisode(date: migraineEpisodeArray[indexPath.row].date!)
        }
        catch {
            print ("ERROR in TablieViewController with find migraine episode")
        }
        print (selectedMigraineEpisode)
        
        //  selectedMigraineEpisode.setValue("BANANA", forKey: #keyPath(MigraineEpisode.medication))
       //self.performSegue(withIdentifier: "segueToInformationViewController", sender: self)
        self.presentInformationViewController()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    private func presentInformationViewController() {
        let viewController = InformationViewController()
        viewController.migraineEpisode = self.selectedMigraineEpisode
        viewController.dataStoreManager = self.dataStoreManager
        self.present(viewController, animated: true)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        print("prepare for segue called")
//        if segue.identifier == "segueToInformationViewController" {
//            let destinationVC = segue.destination as! InformationViewController
//            destinationVC.migraineEpisode = selectedMigraineEpisode
//            destinationVC.dataStoreManager = dataStoreManager
//
//
//        }
//    }
}

//// MARK: - Table view data source
//
//extension FirstViewController {
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("======================cell selected===================")
//       // self.performSegue(withIdentifier: "segueToInformationViewController", sender: self)
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//}
    //MARK: - Subscriber
    
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
    

