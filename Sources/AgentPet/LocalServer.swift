import Foundation
import Swifter

class LocalServer {
    private let server = HttpServer()
    
    func start() {
        server["/feed"] = { request in
            // 取得 context 參數 (例如 success, error)
            let context = request.queryParameters.first(where: { $0.0 == "context" })?.1 ?? "default"
            
            return .async {
                await MainActor.run {
                    PetEngine.shared.handleCLIInteraction(context: context)
                    let responseMsg = " [\(PetEngine.shared.getSprite()) AgentPet]: \(PetEngine.shared.lastWords)"
                    return .ok(.text(responseMsg))
                }
            }
        }
        
        do {
            try server.start(8088)
            print("AgentPet Server started on port 8088")
        } catch {
            print("Server start error: \(error)")
        }
    }
}
