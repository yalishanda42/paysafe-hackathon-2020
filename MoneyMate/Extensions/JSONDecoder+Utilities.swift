import Foundation

extension JSONDecoder {
    
    func decodeJsonResource<T: Decodable>(_ resourceName: String, model: T.Type) throws -> T? {
        guard let URL = Bundle.main.url(forResource: resourceName, withExtension: "json"),
            let jsonData = try? Data(contentsOf: URL) else {
            return nil
        }
        
        return try decode(model, from: jsonData)
    }
}
