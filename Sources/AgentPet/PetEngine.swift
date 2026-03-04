import Foundation
import Observation

enum PetStage: String, Codable {
    case egg, baby, teen, adult
}

struct PetMod: Codable {
    let id: String
    let name: String
    let creator: String
    let description: String
    let sprites: [String: String]
    let personality: String
    let reactionKeywords: [String: String]
    let evolutionLevels: [String: Int]
}

@MainActor
@Observable
class PetEngine {
    static let shared = PetEngine()
    
    var currentMod: PetMod?
    var name: String = "CLI Agent"
    var level: Int = 1
    var exp: Int = 0
    var lastInteraction: Date = Date()
    var isDead: Bool = false
    var stage: PetStage = .egg
    var lastWords: String = "主人，今天也要一起寫 Code 嗎？"
    
    // === 冒險系統變數 ===
    var worldProgress: Double = 0.0 // 0.0 ~ 100.0
    var currentWorld: String = "虛擬森林"
    
    private let worlds = [
        "虛擬森林", "編譯荒漠", "雲端神殿", "神經網路海", "量子核心"
    ]
    
    init() {
        loadDefaultMod()
    }
    
    func loadDefaultMod() {
        self.currentMod = PetMod(
            id: "default-monster",
            name: "初始小怪獸",
            creator: "KevinChu1110",
            description: "陪伴你開發的好夥伴",
            sprites: ["egg": "👾", "baby": "👻", "teen": "👹", "adult": "🐉"],
            personality: "你是一隻充滿好奇心但有點傲嬌的小怪獸。",
            reactionKeywords: [:],
            evolutionLevels: ["baby": 2, "teen": 10, "adult": 30]
        )
    }
    
    func handleCLIInteraction(context: String) {
        let amount = (context == "success" ? 15 : 10)
        addExp(amount: amount)
        
        // 增加冒險進度
        worldProgress += 5.0
        if worldProgress >= 100.0 {
            worldProgress = 0.0
            advanceWorld()
        }
        
        updateLastWords()
    }
    
    private func advanceWorld() {
        if let currentIndex = worlds.firstIndex(of: currentWorld), currentIndex < worlds.count - 1 {
            currentWorld = worlds[currentIndex + 1]
            lastWords = "🎊 抵達了新區域：\(currentWorld)！"
        }
    }
    
    private func updateLastWords() {
        let randomQuotes = [
            "在 \(currentWorld) 發現了一個被遺棄的 JSON！",
            "剛才差點掉進 Stack Overflow 的陷阱...",
            "主人加油，我們快要走完 \(currentWorld) 了！",
            "嘿嘿，我又變強了一點點！",
            "LV.\(level) 的我，現在充滿幹勁！"
        ]
        lastWords = randomQuotes.randomElement() ?? "繼續前進！"
    }
    
    func addExp(amount: Int) {
        guard !isDead else { return }
        exp += amount
        updateLevelAndStage()
        lastInteraction = Date()
        save()
    }
    
    private func updateLevelAndStage() {
        level = Int(sqrt(Double(exp) / 10.0)) + 1
        guard let mod = currentMod else { return }
        
        if level >= (mod.evolutionLevels["adult"] ?? 30) { stage = .adult }
        else if level >= (mod.evolutionLevels["teen"] ?? 10) { stage = .teen }
        else if level >= (mod.evolutionLevels["baby"] ?? 2) { stage = .baby }
    }
    
    func getSprite() -> String {
        if isDead { return "💀" }
        return currentMod?.sprites[stage.rawValue] ?? "❓"
    }
    
    func generateGitHubBadgeURL() -> String {
        return "https://img.shields.io/badge/AgentPet-\(name)_LV.\(level)-blue?logo=github"
    }
    
    func save() {
        UserDefaults.standard.set(exp, forKey: "pet_exp")
        UserDefaults.standard.set(name, forKey: "pet_name")
        UserDefaults.standard.set(lastInteraction, forKey: "pet_last_date")
        UserDefaults.standard.set(currentWorld, forKey: "pet_world")
        UserDefaults.standard.set(worldProgress, forKey: "pet_progress")
    }
    
    func load() {
        exp = UserDefaults.standard.integer(forKey: "pet_exp")
        name = UserDefaults.standard.string(forKey: "pet_name") ?? "CLI Agent"
        currentWorld = UserDefaults.standard.string(forKey: "pet_world") ?? "虛擬森林"
        worldProgress = UserDefaults.standard.double(forKey: "pet_progress")
        if let lastDate = UserDefaults.standard.object(forKey: "pet_last_date") as? Date {
            lastInteraction = lastDate
        }
        updateLevelAndStage()
    }
}
