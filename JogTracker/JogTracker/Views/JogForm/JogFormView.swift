import UIKit

protocol JogFormViewDelegate: AnyObject {
    func hideFormView()
    func editSelectedJog(with data: JogExternal)
    func createNewJog(_ jog: JogInternal)
    func showAlertView(title: String, message: String)
}

class JogFormView: UIView {
    // MARK: - IBOutlets
    @IBOutlet weak var distanceTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var mainContainerView: UIView!
    
    // MARK: - lets/vars
    private let cornerRadius = Constants.CornerRadius.self
    private let borderWidth = Constants.BorderWidth.JogForm.self
    private var editedJogExternal: JogExternal?
    public var action: RecordAction?
    weak var delegate: JogFormViewDelegate?
    
    // MARK: - Initialization function
    class func instanceFromNib() -> JogFormView {
        guard let jogFormView = UINib(nibName: "JogFormView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? JogFormView else {
            return JogFormView()
        }
        jogFormView.configure()
        return jogFormView
    }
    
    private func configure() {
        mainContainerView.layer.cornerRadius = cornerRadius.jogFormView
        saveButton.layer.cornerRadius = self.saveButton.frame.height/2
        saveButton.layer.borderWidth = borderWidth.actionButton
        saveButton.layer.borderColor = UIColor.white.cgColor
        distanceTextField.delegate = self
        timeTextField.delegate = self
        dateTextField.delegate = self
    }
    
    public func configure(with object: JogExternal?) {
        guard let jogExternal = object else { return }
        self.editedJogExternal = jogExternal
        distanceTextField.text = "\(jogExternal.distance)"
        timeTextField.text = "\(jogExternal.time)"
        dateTextField.text = "\(jogExternal.date)"
    }
    
    // MARK: - Validation function
    private func validateForm() -> Bool {
        let digitsValidation = NSPredicate(format: "SELF MATCHES %@", "^[0-9]{1,}$")
        let dateValidation = NSPredicate(format: "SELF MATCHES %@", "^[0-9]{2}.[0-9]{2}.[0-9]{4}")
        guard let distance = distanceTextField.text, !distance.isEmpty, digitsValidation.evaluate(with: distance) else {
            delegate?.showAlertView(title: "Oops!", message: "Please enter correct distance.")
            return false
        }
        guard let time = timeTextField.text, !time.isEmpty, digitsValidation.evaluate(with: time) else {
            delegate?.showAlertView(title: "Oops!", message: "Please enter correct time.")
            return false
        }
        guard let date = dateTextField.text, !date.isEmpty, dateValidation.evaluate(with: date) else {
            delegate?.showAlertView(title: "Oops!", message: "Please enter correct date.")
            return false
        }
        return true
    }
    
    // MARK: - IBActions
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        delegate?.hideFormView()
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        if validateForm() {
            guard let distanceText = distanceTextField.text,
                  let distance = Double(distanceText),
                  let timeText = timeTextField.text,
                  let time = Int(timeText),
                  let date = dateTextField.text else {
                return
            }
            if let recordAction = action {
                switch recordAction {
                case .add:
                    delegate?.createNewJog(JogInternal(date: date, time: time, distance: distance))
                case .edit:
                    if let jogExternal = self.editedJogExternal {
                        delegate?.editSelectedJog(with: JogExternal(id: jogExternal.id, userID: jogExternal.userID, distance: distance, time: time, date: jogExternal.date))
                    }
                }
            }
        }
    }
}

extension JogFormView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
}
