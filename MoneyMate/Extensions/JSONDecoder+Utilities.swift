import Foundation

extension JSONDecoder {
    
    func decodeJsonResource<T: Decodable>(_ resourceName: String, model: T.Type) throws -> T? {
        guard let URL = Bundle.main.url(forResource: resourceName, withExtension: "json") else {
            return nil
        }
        
        let jsonData = try Data(contentsOf: URL)
        return try decode(model, from: jsonData)
    }
}
