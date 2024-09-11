import SwiftUI
import RealmSwift

struct ExerciceDetail: View {
    @ObservedRealmObject var exercice: ExerciceRealmModel
    @Binding var showToast: Bool
    @Binding var showDisconnectToast: Bool
    @State private var showConnectButton = false
    @State private var refreshTrigger = false
    
    var body: some View {
        VStack {
            HStack {
                Text(exercice.exerciceName)
                    .bold()
                Spacer()

                Button {
                    toggleConnect()
                } label: {
                    if self.showConnectButton {
                        Image(systemName: "xmark.shield")
                    } else {
                        Image(systemName: "dumbbell")
                    }
                }
                
            }
            .padding(5)
            
            HStack {
                Text("SÉRIE")
                Spacer()
                Text("RÉPÉTITIONS")
                    .onTapGesture {
                        incrementRepetitions()
                    }
                Spacer()
                Text("POIDS (KG)")
            }
            .font(.caption2)
            .foregroundColor(Color.gray)
            .bold()
            .padding(.horizontal, 5)
            
            ScrollView {
                VStack {
                    ForEach(Array(exercice.series.enumerated()), id: \.element.id) { index, serie in
                        SerieDetail(serie: serie, serieIndex: index + 1)
                    }
                    Button(action: addNewSerie) {
                        Image(systemName: "plus.rectangle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 35, height: 35)
                            .foregroundColor(.gray)
                    }
                }
            }
            .id(refreshTrigger)
        }
        .listRowSeparator(.hidden)
        .padding()
        .cornerRadius(10)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 1)
    }
    
    private func addNewSerie() {
        let newSerie = SerieRealmModel()
        newSerie.repetitionNumber = 0
        if showConnectButton {
            newSerie.weight = 5.0
        } else {
            newSerie.weight = 0.0
        }
        
        let realm = try! Realm()
        try! realm.write {
            $exercice.series.append(newSerie)
        }
    }
    
    private func incrementRepetitions() {
        if let lastSerie = exercice.series.last {
            let thawedSerie = lastSerie.thaw()

            if let thawedSerie = thawedSerie {
                let realm = try! Realm()
                try! realm.write {
                    thawedSerie.repetitionNumber += 1
                }
                refreshTrigger.toggle()
            }
        }
    }
    
    private func toggleConnect() {
            showConnectButton.toggle()
            if showConnectButton {
                showToast = true
            } else {
                showDisconnectToast = true
            }
        }

}

#Preview {
    ExerciceDetail(exercice: ExerciceRealmModel(value: [ObjectId(), "Développé couché"]), showToast: .constant(true), showDisconnectToast: .constant(true))
}
