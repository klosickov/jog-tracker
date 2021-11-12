import UIKit

class JogTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // MARK: - Configuration function
    func configure(with object: JogExternal) {
        speedLabel.text = getSpeed(of: object)
        distanceLabel.text = "\(object.distance)"
        timeLabel.text = "\(object.time)"
        dateLabel.text = convertUnixToDate(value: Double(object.time))
    }

    private func convertUnixToDate(value: Double) -> String {
        let date = Date(timeIntervalSince1970: value)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }
    
    private func getSpeed(of object: JogExternal) -> String {
        let speed = object.distance / Double(object.time / 60)
        return String(format: "%.1f", speed)
    }
}
