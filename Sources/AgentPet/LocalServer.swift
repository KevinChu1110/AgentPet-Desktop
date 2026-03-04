import Foundation
import Swifter

class LocalServer {
    private let server = HttpServer()
    
    func start() {
        server["/feed"] = { request in
            let context = request.queryParams.first(where: { $0.0 == "context" })?.1 ?? "default"
            
            // 由於這是同步 handler，我們啟動一個 Task 異步更新 UI
            Task { @MainActor in
                PetEngine.shared.handleCLIInteraction(context: context)
            }
            
            // 這裡回傳一個簡單的 OK 訊息給 CLI
            // 真正的動態台詞會顯示在選單列，或在下次 Hook 時抓取
            return .ok(.text("OK"))
        }
        
        do {
            try server.start(8088)
            print("AgentPet Server started on port 8088")
        } catch {
            print("Server start error: \(error)")
        }
    }
}
