import Foundation
import Observation

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
        
        let randomQuotes = [
            "主人這份 Code 寫得真漂亮！",
            "嘿嘿，我又變強了一點點！",
            "剛才那個 Bug 解決了嗎？",
            "主人加油，你是最棒的工程師！",
            "呼...寫程式好累，但我會陪著你。",
            "LV.\(level) 的我，已經能看懂一點點 Python 了喔！"
        ]
        lastWords = randomQuotes.randomElement() ?? "繼續努力！"
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
    }
    
    func load() {
        exp = UserDefaults.standard.integer(forKey: "pet_exp")
        name = UserDefaults.standard.string(forKey: "pet_name") ?? "CLI Agent"
        if let lastDate = UserDefaults.standard.object(forKey: "pet_last_date") as? Date {
            lastInteraction = lastDate
        }
        updateLevelAndStage()
    }
}
