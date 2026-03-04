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
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(engine.getSprite())
                        .font(.system(size: 32))
                    VStack(alignment: .leading) {
                        Text(engine.name)
                            .font(.headline)
                        Text("LV.\(engine.level) \(engine.stage.rawValue.capitalized)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                
                Text("\"\(engine.lastWords)\"")
                    .font(.system(size: 13, design: .monospaced))
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.blue.opacity(0.05))
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.blue.opacity(0.1), lineWidth: 1)
                    )
                
                ProgressView(value: Double(engine.exp % 100), total: 100)
                    .tint(.green)
                
                Divider()
                
                Group {
                    Button(action: {
                        let pasteboard = NSPasteboard.general
                        pasteboard.clearContents()
                        pasteboard.setString("[![AgentPet](\(engine.generateGitHubBadgeURL()))](https://github.com/KevinChu1110/AgentPet-Desktop)", forType: .string)
                    }) {
                        Label("複製 GitHub 勳章連結", systemImage: "link.badge.plus")
                    }
                    
                    Button(action: {
                        if let url = URL(string: "https://buymeacoffee.com/guanrung11n") {
                            NSWorkspace.shared.open(url)
                        }
                    }) {
                        HStack {
                            Text("☕️ 請我喝杯咖啡")
                            Spacer()
                            Text("Support")
                                .font(.caption2)
                                .padding(.horizontal, 4)
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(4)
                        }
                    }
                }
                
                Divider()
                
                Button("結束 AgentPet") {
                    NSApplication.shared.terminate(nil)
                }
            }
            .padding(12)
            .frame(width: 240)
        } label: {
            Text(engine.getSprite())
        }
    }
}
