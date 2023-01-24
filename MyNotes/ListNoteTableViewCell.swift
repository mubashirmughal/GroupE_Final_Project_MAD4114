
import UIKit

class ListNoteTableViewCell: UITableViewCell {

    static let identifier = "ListNoteTableViewCell"
    
    @IBOutlet weak private var titleLbl: UILabel!
    @IBOutlet weak private var descriptionLbl: UILabel!
    @IBOutlet weak private var noteImageView: UIImageView!
    
    func setup(note: Note) {
        titleLbl.text = note.title
        descriptionLbl.text = note.desc
        if let imageData = note.image {
            noteImageView.image = UIImage(data: imageData)
        } else {
            noteImageView.image = nil
        }
    }
}
