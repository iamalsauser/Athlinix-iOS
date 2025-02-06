import SwiftUI

struct StatsAddView: View {
    
    @ObservedObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    
    
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
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Shooting Stats")) {
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
            .navigationTitle("Add Stats")
            .toolbar {
                ToolbarItem {
                    Button("Send") {
                        Task {
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

struct StatsAddView_Previews: PreviewProvider {
    static var previews: some View {
        StatsAddView(viewModel: ViewModel())
    }
}
