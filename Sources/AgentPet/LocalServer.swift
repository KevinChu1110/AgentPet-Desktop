import Foundation
import Swifter

class LocalServer {
    private let server = HttpServer()
    
    func start() {
        server["/feed"] = { request in
            Task { @MainActor in
                PetEngine.shared.addExp(amount: 10)
                print("Received feed signal from CLI!")
            }
            return .ok(.text("Pet Fed!"))
        }
        
        do {
            try server.start(8088)
            print("AgentPet Server started on port 8088")
        } catch {
            print("Server start error: \(error)")
        }
    }
}
