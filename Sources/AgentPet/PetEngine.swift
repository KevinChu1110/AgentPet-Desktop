import Foundation
import Observation

enum PetStage: String, Codable {
    case egg, baby, teen, adult
}

enum PetType: String, Codable {
    case monster, pet
}

@MainActor
@Observable
class PetEngine {
    static let shared = PetEngine()
    
    var name: String = "CLI Agent"
    var type: PetType = .monster
    var level: Int = 1
    var exp: Int = 0
    var intimacy: Int = 100
    var lastInteraction: Date = Date()
    var isDead: Bool = false
    var stage: PetStage = .egg
    
    func addExp(amount: Int) {
        guard !isDead else { return }
        
        exp += amount
        level = Int(sqrt(Double(exp) / 10.0)) + 1
        
        if level >= 30 { stage = .adult }
        else if level >= 10 { stage = .teen }
        else if level >= 2 { stage = .baby }
        
        lastInteraction = Date()
        intimacy = min(100, intimacy + 2)
        
        save()
    }
    
    func checkSurvival() {
        let threeDays: TimeInterval = 3 * 24 * 60 * 60
        if Date().timeIntervalSince(lastInteraction) > threeDays {
            isDead = true
            save()
        }
    }
    
    func getSprite() -> String {
        if isDead { return "💀" }
        let sprites: [PetType: [PetStage: String]] = [
            .monster: [.egg: "👾", .baby: "👻", .teen: "👹", .adult: "🐉"],
            .pet: [.egg: "🥚", .baby: "🐥", .teen: "🐱", .adult: "🦄"]
        ]
        return sprites[type]?[stage] ?? "❓"
    }
    
    // 簡單的 Persistence
    func save() {
        UserDefaults.standard.set(exp, forKey: "pet_exp")
        UserDefaults.standard.set(name, forKey: "pet_name")
        UserDefaults.standard.set(type.rawValue, forKey: "pet_type")
        UserDefaults.standard.set(lastInteraction, forKey: "pet_last_date")
    }
    
    func load() {
        exp = UserDefaults.standard.integer(forKey: "pet_exp")
        name = UserDefaults.standard.string(forKey: "pet_name") ?? "CLI Agent"
        if let typeStr = UserDefaults.standard.string(forKey: "pet_type"), let t = PetType(rawValue: typeStr) {
            type = t
        }
        if let lastDate = UserDefaults.standard.object(forKey: "pet_last_date") as? Date {
            lastInteraction = lastDate
        }
        addExp(amount: 0) // 觸發等級計算
    }
}
