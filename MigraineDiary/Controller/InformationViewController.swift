//
//  InformationViewController.swift
//  MigraineDiary
//
//  Created by Ольга Егорова on 05.10.2022.
//

import UIKit

class InformationViewController: UIViewController, Subscriber {
        
    var migraineEpisode: MigraineEpisode?
    
    var dataStoreManager: DataStoreManager?
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.red
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var dateLabel: UILabel = getLabel()
    private lazy var triggerLabel: UILabel = getLabel()
    private lazy var auraLabel: UILabel = getLabel()
    private lazy var intensityLabel: UILabel = getLabel()
    
    private lazy var intensityView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var medicationLabel: UILabel  = getLabel()
    private lazy var durationLabel: UILabel = getLabel()
    private lazy var intensityAfterMedicationLabel: UILabel = getLabel()
    
    private lazy var intensityAfterMedicationView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private func getLabel()-> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.adjustsFontSizeToFitWidth = true
        return label
    }

    
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
        button.addTarget(self, action: #selector(changeButtonPressed), for: .touchUpInside)
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
        view.addSubview(stackView)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(triggerLabel)
        stackView.addArrangedSubview(auraLabel)
        stackView.addArrangedSubview(intensityLabel)
        stackView.addArrangedSubview(intensityView)
        stackView.addArrangedSubview(medicationLabel)
        stackView.addArrangedSubview(durationLabel)
        stackView.addArrangedSubview(intensityAfterMedicationLabel)
        stackView.addArrangedSubview(intensityAfterMedicationView)
        view.addSubview(changeButton)
    }
    private func setConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            titleLabel.heightAnchor.constraint(equalToConstant: 25),

            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: changeButton.topAnchor,constant: -10),
            
            changeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            changeButton.heightAnchor.constraint(equalToConstant: 50),
            changeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            changeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
        
        ])
    }
    
//    @IBAction func changeButtonPressed(_ sender: UIButton) {
//
//    }
    
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
        dateLabel.text = presenter.dateLabelText
        triggerLabel.text = presenter.triggersLabelText
        auraLabel.text = presenter.auraLabelText
        intensityLabel.text = presenter.intensityLabelText
        intensityView.image = presenter.intensityView
        medicationLabel.text = presenter.medicationLabelText
        durationLabel.text = presenter.durationLabelText
        intensityAfterMedicationLabel.text = presenter.intensityAfterMedicationLabelText
        intensityAfterMedicationView.image = presenter.intensityAfterMedicationView
        
    }
    
    @objc func changeButtonPressed(sender: UIButton){
        presentChangeBlanckViewController()
    }
    
    private func presentChangeBlanckViewController(){
        let viewController = ChangeBlankViewController()
        viewController.dataStoreManager = dataStoreManager
        viewController.migraineEpisode = migraineEpisode
            self.present(viewController, animated: true)

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


