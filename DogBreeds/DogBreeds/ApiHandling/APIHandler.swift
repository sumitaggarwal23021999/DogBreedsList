import Foundation
import UIKit

// MARK: - Enum APIError
enum APIError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

// MARK: - Class APIHandler
class APIHandler {
    
    /// Common Method used to do API Calling.
    func getDataFromAPI(url: String) async throws -> Any {

        guard let url = URL(string: url) else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
            showAlert()
            throw APIError.invalidResponse
        }
        let anyValue = try JSONSerialization.jsonObject(with: data)
        return anyValue
    }
    
    private func showAlert() {
        DispatchQueue.main.async {
            if let delegate = UIApplication.shared.delegate as? AppDelegate {
                delegate.window?.rootViewController?.showAlertControllerWith(message: .apiFailed, buttons: .ok(nil))
            }
        }
    }
}
