
import UIKit

protocol SearchItemCellDelegate: AnyObject {
	func searchMovieName(movie: String)
}

class SearchItemCell: UICollectionViewCell {
	
	@IBOutlet weak var searchTextField: UITextField!
	@IBOutlet weak var searchButton: UIButton!
	@IBOutlet weak var heading: UILabel!
	@IBOutlet weak var editTextView: UIView!
	@IBOutlet weak var searchIcon: UIImageView!
	
	weak var delegate: SearchItemCellDelegate?
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	public func config(showKeyboard:Bool = false) {
		heading.text = "Search your favorite movie"
		searchTextField.delegate = self
		editTextView.layer.cornerRadius = 12.0
		editTextView.layer.borderWidth = 1.0
 		searchButton.setTitle("Search", for: .normal)
		if(showKeyboard) {
			self.searchTextField.becomeFirstResponder()
		}
	}
	 
	@IBAction func searchButtonTapped(_ sender: Any) {
		let movie = self.searchTextField.text ?? ""
		if(movie.isEmpty){
			return
		}
		self.delegate?.searchMovieName(movie: movie)
	}
	
}
extension SearchItemCell:UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		let movie = self.searchTextField.text ?? ""
		if(movie.isEmpty){
			return true
		}
		self.delegate?.searchMovieName(movie: self.searchTextField.text ?? "")
		textField.resignFirstResponder()
		return true
	}
 	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		return (textField.text?.count ?? 0) < 12;
	}
}
