import Foundation
import UIKit

class StreamDetailsView: UIViewController {
    @IBOutlet weak var DJName: UITextField!
    @IBOutlet weak var DJNameUpdated: UITextField!
    @IBOutlet weak var DJStyle: UITextField!
    @IBOutlet weak var DJStyleUpdated: UITextField!
    @IBOutlet weak var ListenersCurrent: UITextField!
    @IBOutlet weak var ListenersPeak: UITextField!
    
    var djName: String = "Michael"
    var djStyle: String = "Mellow, wistful music"
    var listenersCurrent: String = "0"
    var listenersPeak: String = "0"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Default DJ info values displayed
        DJName.text = "DJ Name: \(djName)"
        DJStyle.text = "DJ Style: \(djStyle)"
        ListenersCurrent.text = "Listeners(current): \(listenersCurrent)"
        ListenersPeak.text = "Listeners(peak): \(listenersPeak)"
        
        // Dynamically update the stream stats, the current and peak listeners
        let urlString = "http://152.17.49.84:8000"
        guard let url = URL(string: urlString) else {
            print("Error: \(urlString) doesn't seem to be a valid URL")
            return
        }

        do {
            let html = try String(contentsOf: url, encoding: .ascii)
            print("HTML : \(html)")
            
            // Helper function to extract numbers
            func extractNumber(from html: String, startingAt startIndex: String.Index) -> String {
                var currentIndex = startIndex
                var extractedNumber = ""
                
                while currentIndex < html.endIndex, html[currentIndex].isNumber {
                    extractedNumber.append(html[currentIndex])
                    currentIndex = html.index(after: currentIndex)
                }
                
                return extractedNumber
            }
            
            // Extract current listeners
            let searchString1 = "Listeners (current):</td><td class=\"streamstats\">"
            if let range = html.range(of: searchString1) {
                let numberStartIndex = html.index(range.upperBound, offsetBy: 0)
                let currentListeners = extractNumber(from: html, startingAt: numberStartIndex)
                ListenersCurrent.text = "Listeners(current): \(currentListeners)"
                print("Current listeners: \(currentListeners)")
            } else {
                print("Search string not found for current listeners")
            }
            
            // Extract peak listeners
            let searchString2 = "Listeners (peak):</td><td class=\"streamstats\">"
            if let range = html.range(of: searchString2) {
                let numberStartIndex = html.index(range.upperBound, offsetBy: 0)
                let peakListeners = extractNumber(from: html, startingAt: numberStartIndex)
                ListenersPeak.text = "Listeners(peak): \(peakListeners)"
                print("Peak listeners: \(peakListeners)")
            } else {
                print("Search string not found for peak listeners")
            }
        } catch let error {
            print("Error: \(error)")
        }
    }
}
