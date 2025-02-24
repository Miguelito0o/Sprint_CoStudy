//
//  MateriaView.swift
//  CoStudyOficial
//
//  Created by found on 19/02/25.
//
import SwiftUI

struct MateriaView : View {
    
    @Binding var materia : Materia
    @State private var ModalCriarTopico = false
    @State private var ModalCriarConteudo = false
    @State private var novoTopicoNome = ""
    @State private var topicosEmExpansão: Set<UUID> = []
    
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
                
                ScrollView {
                    LazyVStack {
                        ForEach(materia.topicos) { topico in
                            VStack {
                                HStack {
                                    Text("\(topico.nome)")
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                        .foregroundStyle(Color(hex: "00504C"))
                                }
                                .onTapGesture {
                                    if topicosEmExpansão.contains(topico.id){
                                        topicosEmExpansão.remove(topico.id)
                                    }
                                    else {
                                        topicosEmExpansão.insert(topico.id)
                                    }
                                }
                                Divider()
                                    .padding(.bottom, 16)
                                
                                if topicosEmExpansão.contains(topico.id) {
                                    VStack(alignment: .leading) {
                                        HStack{
                                            Button(action: {
                                                ModalCriarConteudo = true
                                            }) {
                                                Image(systemName: "plus.square.fill")
                                                    .foregroundStyle(Color(hex: "00504C"))
                                                    .font(.system(size: 20))
                                                    .padding(.horizontal, 16)
                                            }
                                            Text("Adicionar Conteúdo")
                                            .font(Font.custom("SF Pro", size: 15).weight(.bold))
                                            .lineSpacing(22)
                                            .foregroundStyle(Color(hex: "3C3C43"))
                                        }
                                        Divider()
                                            .padding(.bottom, 16)
                                        if !topico.conteudos.isEmpty {
                                            ForEach(topico.conteudos) {_ in 
                                                NavigationLink(destination: ConteudoView(topico: topico)) {
                                                    HStack {
                                                        Image(systemName: "document.fill")
                                                            .foregroundStyle(Color(hex: "00504C"))
                                                            .font(.system(size: 17))
                                                            .padding(.horizontal, 16)
                                                        Text("Nome de conteúdo")
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    .padding(.horizontal, 32)
                                }
                                
                            }
                            .padding(.horizontal, 16)
                            .sheet(isPresented: $ModalCriarConteudo) {
                                ModalCriarConteudoView()
                                    .presentationDetents([.fraction(0.2)])
                            }
                        }
                    }
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
                        Image(systemName: "plus.square.fill")
                            .foregroundStyle(Color(hex: "00504C"))
                            .font(.system(size: 25))
                    }
                    .tint(Color(hex: "00504C"))
                }
            }
            .sheet(isPresented: $ModalCriarTopico) {
                ModalCriarTopicoView(materia: $materia)
                    .presentationDetents([.fraction(0.2)])
                    
            }
        }
        .overlay {
            if materia.topicos.isEmpty {
                ContentUnavailableView(label: {
                    HStack {
                        Spacer()
                        
                        Image(systemName: "arrow.turn.right.up")
                            .foregroundStyle(Color(hex: "D1D1D1"))
                            .font(.system(size: 60))
                            .offset(y: -210)
                            .padding(.trailing, -27)
                    }
                    Label {
                        Text("Que tal adicionarmos um conteúdo?")
                            .fontWeight(.regular)
                    } icon: {
                        Image(systemName: "document.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 152, height: 115)
                            .foregroundColor(Color(hex: "D1D1D1"))
                        
                        
                    }
                }, description: {
                    Text("Clique no botão sinalizado para adicionar um novo conteúdo!")
                        .padding(.horizontal)
                        .padding(.trailing, 16)
                        .padding(.leading, 16)
                })
            }
        }
    }
}
