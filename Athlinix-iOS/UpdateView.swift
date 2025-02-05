import SwiftUI

struct UpdateStatsView: View {
    @ObservedObject var viewModel: ViewModel
    let stats: Statistics
    
    // Local state for the editable fields
    @State private var tpm = ""
    @State private var threepm = ""
    @State private var ftm = ""
    @State private var tpa = ""
    @State private var threepa = ""
    @State private var fta = ""
    @State private var oreb = ""
    @State private var dreb = ""
    @State private var ast = ""
    @State private var toStat = ""
    @State private var stl = ""
    @State private var pf = ""
    @State private var blk = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Update Shooting Stats")) {
                    TextField("TPM (2-point Made)", text: $tpm)
                        .keyboardType(.numberPad)
                    TextField("3PM (3-point Made)", text: $threepm)
                        .keyboardType(.numberPad)
                    TextField("FTM (Free Throw Made)", text: $ftm)
                        .keyboardType(.numberPad)
                    TextField("TPA (2-point Attempt)", text: $tpa)
                        .keyboardType(.numberPad)
                    TextField("3PA (3-point Attempt)", text: $threepa)
                        .keyboardType(.numberPad)
                    TextField("FTA (Free Throw Attempt)", text: $fta)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Other Stats")) {
                    TextField("OREB", text: $oreb)
                        .keyboardType(.numberPad)
                    TextField("DREB", text: $dreb)
                        .keyboardType(.numberPad)
                    TextField("AST", text: $ast)
                        .keyboardType(.numberPad)
                    TextField("TO", text: $toStat)
                        .keyboardType(.numberPad)
                    TextField("STL", text: $stl)
                        .keyboardType(.numberPad)
                    TextField("PF", text: $pf)
                        .keyboardType(.numberPad)
                    TextField("BLK", text: $blk)
                        .keyboardType(.numberPad)
                }
            }
            .navigationTitle("Update Stats")
            .onAppear {
                // Pre-populate fields with current values from the stats record
                tpm = "\(stats.tpm)"
                threepm = "\(stats.threepm)"
                ftm = "\(stats.ftm)"
                tpa = "\(stats.tpa)"
                threepa = "\(stats.threepa)"
                fta = "\(stats.fta)"
                oreb = "\(stats.oreb)"
                dreb = "\(stats.dreb)"
                ast = "\(stats.ast)"
                toStat = "\(stats.to)"
                stl = "\(stats.stl)"
                pf = "\(stats.pf)"
                blk = "\(stats.blk)"
            }
            .toolbar {
                ToolbarItem {
                    Button("Update") {
                        Task {
                            // Create the update payload using our helper struct.
                            let update = ViewModel.StatisticsUpdate(
                                tpm: Int(tpm),
                                threepm: Int(threepm),
                                ftm: Int(ftm),
                                tpa: Int(tpa),
                                threepa: Int(threepa),
                                fta: Int(fta),
                                oreb: Int(oreb),
                                dreb: Int(dreb),
                                ast: Int(ast),
                                to: Int(toStat),
                                stl: Int(stl),
                                pf: Int(pf),
                                blk: Int(blk)
                            )
                            do {
                                try await viewModel.addStatistics(newValues: update)
                                dismiss()
                            } catch {
                                print("Error updating stats: \(error)")
                            }
                        }
                    }
                }
            }
        }
    }
}

struct UpdateStatsView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyStats = Statistics(
            id: 1,
            createdAt: Date(),
            userID: UUID(),
            tp: 10,
            fgm: 5,
            fga: 12,
            tpm: 2,
            tpa: 7,
            threepm: 3,
            threepa: 5,
            ftm: 5,
            fta: 6,
            oreb: 1,
            dreb: 4,
            ast: 3,
            to: 2,
            stl: 1,
            pf: 2,
            blk: 0,
            isComplete: false
        )
        UpdateStatsView(viewModel: ViewModel(), stats: dummyStats)
    }
}
