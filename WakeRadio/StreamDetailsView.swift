import UIKit

class StreamDetailsView: UIViewController {
    @IBOutlet weak var DJName: UITextField!
    @IBOutlet weak var DJStyle: UITextField!
    @IBOutlet weak var ListenersCurrent: UITextField!
    @IBOutlet weak var ListenersPeak: UITextField!

    // Variables to store DJ info
    var djName: String {
        get {
            UserDefaults.standard.string(forKey: "djName") ?? "Default DJ"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "djName")
        }
    }
    
    var djStyle: String {
        get {
            UserDefaults.standard.string(forKey: "djStyle") ?? "Default Style"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "djStyle")
        }
    }

    // Variables for listeners
    var listenersCurrent: String = "0"
    var listenersPeak: String = "0"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load and display DJ info
        DJName.text = "DJ Name: \(djName)"
        DJStyle.text = "DJ Style: \(djStyle)"
        
        // Load and display listener stats
        ListenersCurrent.text = "Listeners (current): \(listenersCurrent)"
        ListenersPeak.text = "Listeners (peak): \(listenersPeak)"
        
        // Fetch listener stats
        fetchListenerStats()
    }
    
    func updateDJInfo(djName: String, djStyle: String) {
        self.djName = djName
        self.djStyle = djStyle
        DJName.text = "DJ Name: \(djName)"
        DJStyle.text = "DJ Style: \(djStyle)"
        print("Updated DJ Info - Name: \(djName), Style: \(djStyle)")
    }

    private func fetchListenerStats() {
        let urlString = "http://152.17.49.84:8000"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        DispatchQueue.global().async {
            do {
                let html = try String(contentsOf: url, encoding: .ascii)
                DispatchQueue.main.async {
                    self.parseListenerStats(from: html)
                }
            } catch {
                print("Error fetching stats: \(error)")
            }
        }
    }

    private func parseListenerStats(from html: String) {
        func extractNumber(from html: String, startingAt startIndex: String.Index) -> String {
            var currentIndex = startIndex
            var extractedNumber = ""
            while currentIndex < html.endIndex, html[currentIndex].isNumber {
                extractedNumber.append(html[currentIndex])
                currentIndex = html.index(after: currentIndex)
            }
            return extractedNumber
        }

        let currentKey = "Listeners (current):</td><td class=\"streamstats\">"
        if let range = html.range(of: currentKey) {
            let startIndex = html.index(range.upperBound, offsetBy: 0)
            listenersCurrent = extractNumber(from: html, startingAt: startIndex)
            ListenersCurrent.text = "Listeners (current): \(listenersCurrent)"
        }

        let peakKey = "Listeners (peak):</td><td class=\"streamstats\">"
        if let range = html.range(of: peakKey) {
            let startIndex = html.index(range.upperBound, offsetBy: 0)
            listenersPeak = extractNumber(from: html, startingAt: startIndex)
            ListenersPeak.text = "Listeners (peak): \(listenersPeak)"
        }
    }
}
