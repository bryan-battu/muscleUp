import SwiftUI
import RealmSwift

struct ExerciceDetail: View {
    @ObservedRealmObject var exercice: ExerciceRealmModel
    
    var body: some View {
        VStack {
            HStack {
                Text(exercice.exerciceName)
                    .bold()
                Spacer()
            }
            .padding(5)
            
            HStack {
                Text("SÉRIE")
                Spacer()
                Text("RÉPÉTITIONS")
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
                            .aspectRatio(contentMode: .fit)  // Maintient le ratio d'aspect rectangulaire
                            .frame(width: 35, height: 35)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(10)
    }
    
    private func addNewSerie() {
        let newSerie = SerieRealmModel()
        newSerie.repetitionNumber = 0
        newSerie.weight = 0.0
        
        let realm = try! Realm()
        try! realm.write {
            $exercice.series.append(newSerie)
        }
    }
}

#Preview {
    ExerciceDetail(exercice: ExerciceRealmModel(value: [ObjectId(), "Développé couché"]))
}
