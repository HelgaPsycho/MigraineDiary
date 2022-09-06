//
//  TableViewCell.swift
//  MigraineDiary
//
//  Created by Ольга Егорова on 04.09.2022.
//

import UIKit

class MigraineEpisodeCell: UITableViewCell {

     static let identifier = "migraineEpisodeCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MigraineEpisodeCell", bundle: nil)
        // nibName - название файла xib
    }
    
    public func configure (date: String, medication: String, image: UIImage){
        dateLabel.text = date
        medicationLabel.text = medication
        scaleImage.image = image
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var medicationLabel: UILabel!
    
    @IBOutlet weak var scaleImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    
    
}
