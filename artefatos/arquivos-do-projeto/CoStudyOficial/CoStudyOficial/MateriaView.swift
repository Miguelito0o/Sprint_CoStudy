//
//  MateriaView.swift
//  CoStudyOficial
//
//  Created by found on 19/02/25.
//
import SwiftUI


struct MateriaView : View {
    
    @Binding var materia : Materia
    var turma : Turma
    @State var ModalCriarTopico = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            //"Filtro" amarelo
            Color(hex: "FFFBEF")
                .ignoresSafeArea(.all)
                .allowsHitTesting(false)
            
            VStack {
                //Título
                HStack {
                    Text("Conteúdos")
                        .font(.system(size: 31, weight: .semibold))
                        .tracking(1.5)
                        .padding(.leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .overlay {
                if materia.topicos.isEmpty {
                    ContentUnavailableView(label: {
                        HStack {
                            Spacer()
                            
                            Image(systemName: "arrow.turn.right.up")
                                .foregroundStyle(Color(hex: "D1D1D1"))
                                .font(.system(size: 60))
                                .offset(y: -225)
                                .padding(.trailing, -27)
                        }
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
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .navigationBarBackButtonHidden(true)
            .navigationTitle("\(materia.nome)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button(action: { dismiss() }) {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(Color(hex: "00504C"))
                            Text("Matérias")
                                .tint(Color(hex: "00504C"))
                        }
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        ModalCriarTopico = true
                    }) {
                        Image(systemName: "document.fill")
                            .foregroundStyle(Color(hex: "00504C"))
                            .font(.system(size: 25))
                    }
                    .tint(Color(hex: "00504C"))
                }
            }
            .sheet(isPresented: $ModalCriarTopico) {
                ModalCriarTopicoView()
                    .presentationDetents([.fraction(0.2)])
                    
            }
        }
    }
}
