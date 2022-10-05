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
    var dateOfMigraineEpisode: Date = Date(timeIntervalSinceNow: 0)
    //ДАТА не включает секунды, поэтому модели созданные в течение одной минуты идеют одинаковую дату -> при удалении таких объектов они удаляются рандомно
    public func configure (date: Date, medication: String, image: UIImage){
        dateLabel.text = formateDateToString(date: date)
        medicationLabel.text = medication
        scaleImage.image = image
        dateOfMigraineEpisode = date
    }
    func formateDateToString (date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        let formatedDate = dateFormatter.string(from: date)
        return formatedDate
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
