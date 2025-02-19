//
//  TurmaView.swift
//  CoStudyOficial
//
//  Created by found on 11/02/25.
//
import SwiftUI

struct TurmaView: View {
    
    @Binding var turma: Turma
    @State private var ModalCriarMateria = false
    @State private var searchText = "" // Search state
    
    @Environment(\.dismiss) var dismiss
    
    var materiasFiltradas : [Materia] {
        if searchText.isEmpty {
            return turma.materias
        } else {
            return turma.materias.filter { $0.nome.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        ZStack {
            Color(hex: "FFFBEF")
                .ignoresSafeArea(.all)
                .allowsHitTesting(false)
            
            VStack {
                VStack(alignment: .leading) {
                    Text("Matérias")
                        .font(.system(size: 31, weight: .semibold))
                        .tracking(1.5)
                        .padding(.leading)
                    
                    Text("Código da turma: \(turma.codigo)")
                        .padding(.leading)
                        .fontWeight(.light)
                        .italic()
                }
                .padding(.top, 10)

                // Search Bar
                SearchBar(text: $searchText)
                    .padding(.horizontal)

                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(materiasFiltradas.indices, id: \.self) { index in
                            NavigationLink(destination: MateriaView(materia: $turma.materias[index])) {
                                HStack {
                                    Text(turma.materias[index].nome)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 2)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { dismiss() }) {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(Color(hex: "00504C"))
                            Text("Turmas")
                                .tint(Color(hex: "00504C"))
                        }
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        ModalCriarMateria = true
                    }) {
                        Image(systemName: "plus.square.fill")
                            .foregroundStyle(Color(hex: "00504C"))
                            .font(.system(size: 25))
                    }
                    .tint(Color(hex: "00504C"))
                }
            }
            .sheet(isPresented: $ModalCriarMateria) {
                ModalCriarMateriaView(turma: $turma)
                    .presentationDetents([.fraction(0.2)])
            }
        }
        .overlay {
            if turma.materias.isEmpty {
                ContentUnavailableView(label: {
                    Label {
                        Text("Adicione uma matéria!")
                            .fontWeight(.regular)
                    } icon: {
                        Image(.elBook)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 152, height: 115)
                            .foregroundColor(Color(hex: "D1D1D1"))
                    }
                }, description: {
                    Text("Sem matérias por enquanto, tente adicionar uma!")
                        .padding(.horizontal)
                        .padding(.trailing, 16)
                        .padding(.leading, 16)
                })
            }
        }
    }
}
