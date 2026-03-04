import SwiftUI
import AppKit

@main
struct AgentPetApp: App {
    @State private var engine = PetEngine.shared
    private let server = LocalServer()
    
    init() {
        NSApplication.shared.setActivationPolicy(.accessory)
        PetEngine.shared.load()
        server.start()
    }
    
    var body: some Scene {
        MenuBarExtra {
            // 在 MenuBarExtra 中，必須使用標準的選單元件
            VStack(alignment: .leading) {
                Text("\(engine.name) (LV.\(engine.level))")
                Text("區域: \(engine.currentWorld) (\(Int(engine.worldProgress))%)")
                Text("\"\(engine.lastWords)\"")
                
                Divider()
                
                Button("📋 複製 GitHub 勳章連結") {
                    let pasteboard = NSPasteboard.general
                    pasteboard.clearContents()
                    pasteboard.setString("[![AgentPet](\(engine.generateGitHubBadgeURL()))](https://github.com/KevinChu1110/AgentPet-Desktop)", forType: .string)
                }
                
                Button("☕️ 請我喝杯咖啡") {
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
