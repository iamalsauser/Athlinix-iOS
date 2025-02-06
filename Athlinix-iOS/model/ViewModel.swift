import Foundation
import Supabase
import SwiftUI

enum Table {
    static let statistics = "Statistics"
}

enum AuthAction: String, CaseIterable {
    case signUp = "Sign Up"
    case signIn = "Sign In"
}

@MainActor
final class ViewModel: ObservableObject {
    
    @Published var isAuthenticated = false
    @Published var authAction: AuthAction = .signUp
    
    @Published var statistics: Statistics?
    
    @Published var showingAuthView = false
    @Published var email = ""
    @Published var password = ""
    @Published var isOnboardingCompleted: Bool = false
    
    let supabase = SupabaseClient(supabaseURL: Secrets.projectURL, supabaseKey: Secrets.apiKey)
    
    // MARK: - Database Functions for Statistics
    
    func fetchStatistics() async throws {
        let user = try await supabase.auth.session.user
        
        let stats: [Statistics] = try await supabase
            .from(Table.statistics)
            .select()
            .eq("user_id", value: user.id)
            .execute()
            .value
        
        if let existingStats = stats.first {
            DispatchQueue.main.async {
                self.statistics = existingStats
            }
        } else {
            let newStats = Statistics(
                createdAt: Date(),
                userID: user.id,
                tp: 0,
                fgm: 0,
                fga: 0,
                tpm: 0,
                tpa: 0,
                threepm: 0,
                threepa: 0,
                ftm: 0,
                fta: 0,
                oreb: 0,
                dreb: 0,
                ast: 0,
                to: 0,
                stl: 0,
                pf: 0,
                blk: 0,
                isComplete: false,
                fgp: nil,
                threepp: nil,
                ftp: nil,
                tpp: nil,
                efgp: nil,
                tsp: nil,
                top: nil
            )
            
            let response: [Statistics] = try await supabase
                .from(Table.statistics)
                .insert(newStats, returning: .representation)
                .select()
                .execute()
                .value
            
            if let insertedStats = response.first {
                DispatchQueue.main.async {
                    self.statistics = insertedStats
                }
            }
        }
    }
    
    struct StatisticsUpdate {
        var tpm: Int?
        var threepm: Int?
        var ftm: Int?
        var tpa: Int?
        var threepa: Int?
        var fta: Int?
        var oreb: Int?
        var dreb: Int?
        var ast: Int?
        var to: Int?
        var stl: Int?
        var pf: Int?
        var blk: Int?
    }
    
    func addStatistics(newValues: StatisticsUpdate) async throws {
        if statistics == nil {
            try await fetchStatistics()
        }
        guard var current = statistics, let id = current.id else { return }
        
        
        let addTP = (newValues.tpm ?? 0)*2 + (newValues.threepm ?? 0)*3 + (newValues.ftm ?? 0)
        let addFGM = (newValues.tpm ?? 0) + (newValues.threepm ?? 0)
        let addFGA = (newValues.tpa ?? 0) + (newValues.threepa ?? 0)
        
        
        current.tp   += addTP
        current.fgm  += addFGM
        current.fga  += addFGA
        
        
        current.tpm      += newValues.tpm ?? 0
        current.threepm  += newValues.threepm ?? 0
        current.ftm      += newValues.ftm ?? 0
        current.tpa      += newValues.tpa ?? 0
        current.threepa  += newValues.threepa ?? 0
        current.fta      += newValues.fta ?? 0
        current.oreb     += newValues.oreb ?? 0
        current.dreb     += newValues.dreb ?? 0
        current.ast      += newValues.ast ?? 0
        current.to       += newValues.to ?? 0
        current.stl      += newValues.stl ?? 0
        current.pf       += newValues.pf ?? 0
        current.blk      += newValues.blk ?? 0
        
        
        current.fgp = current.fga > 0 ? Float(current.fgm) / Float(current.fga) * 100 : nil
        current.threepp = current.threepa > 0 ? Float(current.threepm) / Float(current.threepa) * 100 : nil
        current.ftp = current.fta > 0 ? Float(current.ftm) / Float(current.fta) * 100 : nil
        current.tpp = current.tpa > 0 ? Float(current.tpm) / Float(current.tpa) * 100 : nil
        current.efgp = current.fga > 0 ? (Float(current.tpm) + 1.5 * Float(current.threepm)) / Float(current.fga) * 100 : nil
        
        
        let fgaFloat = Float(current.fga)
        let ftaFloat = Float(current.fta)
        let tpFloat = Float(current.tp)
        
        let tspDenominator = fgaFloat + 0.44 * ftaFloat
        current.tsp = tspDenominator > 0 ? (0.5 * tpFloat) / tspDenominator * 100 : nil
        
        
        let astFloat = Float(current.ast)
        let toFloat = Float(current.to)
        
        let topDenominator = fgaFloat + 0.44 * ftaFloat + astFloat + toFloat
        current.top = topDenominator > 0 ? toFloat / topDenominator * 100 : nil
        
        
        let updatedStats: [Statistics] = try await supabase
            .from(Table.statistics)
            .update(current)
            .eq("id", value: id)
            .select()
            .execute()
            .value
        
        if let updated = updatedStats.first {
            DispatchQueue.main.async {
                self.statistics = updated
            }
        }
    
    }
    
    // MARK: - Authentication Functions
    
    func signUp() async throws {
            _ = try await supabase.auth.signUp(email: email, password: password)
            try await fetchStatistics()
                    
        }
    
    func signIn() async throws {
        _ = try await supabase.auth.signIn(email: email, password: password)
        try await fetchStatistics()
    }
    
    func isUserAuthenticated() async {
        do {
            _ = try await supabase.auth.session.user
            isAuthenticated = true
            try await fetchStatistics()
        } catch {
            isAuthenticated = false
        }
    }
    
    func signOut() async throws {
        try await supabase.auth.signOut()
        isAuthenticated = false
        statistics = nil
    }
    
    func authorize() async throws {
        switch authAction {
        case .signUp:
            try await signUp()
        case .signIn:
            try await signIn()
        }
        isAuthenticated=true
    }
}
