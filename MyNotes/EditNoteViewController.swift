import UIKit

class EditNoteViewController: UIViewController {
    
    static let identifier = "EditNoteViewController"
    
    var note: Note!
    weak var delegate: ListNotesDelegate?
    var image: UIImage?

    @IBOutlet weak private var textView: UITextView!
    @IBOutlet weak private var noteImageView: UIImageView!
    @IBOutlet weak private var addImageBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = note?.text
        if let imageData = note.image {
            noteImageView.image = UIImage(data: imageData)
            addImageBtn.setTitle("", for: .normal)
        } else {
            noteImageView.image = nil
            addImageBtn.setTitle("Add Image", for: .normal)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        textView.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func addImageBtnTapped(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    // MARK:- Methods to implement
    private func updateNote() {
        if let image = image {
            note.image = image.pngData()
        }
        note.lastUpdated = Date()
        CoreDataManager.shared.save()
        delegate?.refreshNotes()
    }
    
    private func deleteNote() {
        delegate?.deleteNote(with: note.id)
        CoreDataManager.shared.deleteNote(note)
    }
}

// MARK:- UITextView Delegate
extension EditNoteViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        note?.text = textView.text
        if note?.text.isEmpty ?? true {
            deleteNote()
        } else {
            updateNote()
        }
    }
}

// MARK:- UIImagePickerController Delegate
extension EditNoteViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.image = image
            noteImageView.image = image
            addImageBtn.setTitle("", for: .normal)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

