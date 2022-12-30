//
//  InformationViewController.swift
//  MigraineDiary
//
//  Created by Ольга Егорова on 05.10.2022.
//

import UIKit

class InformationViewController: UIViewController, Subscriber {
        
    var migraineEpisode: MigraineEpisode!
    
    var dataStoreManager: DataStoreManager!
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.red
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var dateLabel: UILabel!
//
//    @IBOutlet weak var triggerLabel: UILabel!
//
//    @IBOutlet weak var auraLabel: UILabel!
//
//    @IBOutlet weak var intensityLabel: UILabel!
//    @IBOutlet weak var intensityView: UIImageView!
//
//    @IBOutlet weak var medicationLabel: UILabel!
//
//    @IBOutlet weak var durationLabel: UILabel!
//
//    @IBOutlet weak var intensityAfterMedicationLabel: UILabel!
//
//    @IBOutlet weak var intensityAfterMedicationView: UIImageView!

    
    private lazy var changeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.backgroundColor = .red
        button.setTitle("CHANGE", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .highlighted)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        dataStoreManager!.subscribe(subscriber: self)
        
         getOutletsValue()
        
        setHierarhy()
        setConstraints()
         
    }
    
    private func setHierarhy() {
        view.addSubview(titleLabel)
        view.addSubview(changeButton)
    }
    private func setConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            titleLabel.heightAnchor.constraint(equalToConstant: 25),

            
            
            changeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            changeButton.heightAnchor.constraint(equalToConstant: 50),
            changeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            changeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100)
        ])
    }
    
    @IBAction func changeButtonPressed(_ sender: UIButton) {
        
    }
    
    func formateDateToString (date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        let formatedDate = dateFormatter.string(from: date)
        return formatedDate
    }
    
    func getOutletsValue () {
        
        guard let selectedMigrainEpisode = migraineEpisode else {
            print ("No migrain episode find")
            return }
        
        let presenter = InformationViewControllerPresenter (migraineEpisode: selectedMigrainEpisode)
        
        titleLabel.text = presenter.title
//        dateLabel.text = presenter.dateLabelText
//        triggerLabel.text = presenter.triggersLabelText
//        auraLabel.text = presenter.auraLabelText
//        intensityLabel.text = presenter.intensityLabelText
//        intensityView.image = presenter.intensityView
//        medicationLabel.text = presenter.medicationLabelText
//        durationLabel.text = presenter.durationLabelText
//        intensityAfterMedicationLabel.text = presenter.intensityAfterMedicationLabelText
//        intensityAfterMedicationView.image = presenter.intensityAfterMedicationView
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeBlankSegue" {
            let destinationVC = segue.destination as! ChangeBlankViewController
            destinationVC.migraineEpisode = migraineEpisode
            destinationVC.dataStoreManager = dataStoreManager

        
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func update() {
        
        getOutletsValue()
    
    }
    
    
}


