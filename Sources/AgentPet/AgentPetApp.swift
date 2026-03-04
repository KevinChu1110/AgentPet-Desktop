import SwiftUI
import AppKit

@main
struct AgentPetApp: App {
    // 改用 @State 配合 @Observable
    @State private var engine = PetEngine.shared
    private let server = LocalServer()
    
    init() {
        NSApplication.shared.setActivationPolicy(.accessory)
        PetEngine.shared.load()
        PetEngine.shared.checkSurvival()
        server.start()
    }
    
    var body: some Scene {
        MenuBarExtra {
            VStack(alignment: .leading) {
                Text("\(engine.name) (LV.\(engine.level))")
                    .font(.headline)
                
                Text("EXP: \(engine.exp % 100)/100")
                    .font(.caption)
                
                Divider()
                
                Button("切換主題 (\(engine.type == .monster ? "怪獸" : "寵物"))") {
                    engine.type = (engine.type == .monster ? .pet : .monster)
                    engine.save()
                }
                
                Button("☕️ 支持開發者") {
                    if let url = URL(string: "https://buymeacoffee.com/guanrung11n") {
                        NSWorkspace.shared.open(url)
                    }
                }
                
                Divider()
                
                Button("結束 AgentPet") {
                    NSApplication.shared.terminate(nil)
                }
            }
        } label: {
            Text(engine.getSprite())
        }
    }
}
