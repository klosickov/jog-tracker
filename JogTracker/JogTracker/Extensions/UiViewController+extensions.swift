import UIKit

var vSpinner : UIView?

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func startSpinner() {
        let spinnerView = UIView(frame: self.view.bounds)
        spinnerView.backgroundColor = .systemGray
        spinnerView.alpha = 0.5
        let ai = UIActivityIndicatorView(style: .large)
        ai.color = .white
        ai.alpha = 1
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            self.view.addSubview(spinnerView)
        }
        vSpinner = spinnerView
    }
    
    func stopSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
