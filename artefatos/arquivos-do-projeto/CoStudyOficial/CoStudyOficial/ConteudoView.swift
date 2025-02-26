//
//  ConteudoView.swift
//  CoStudyOficial
//
//  Created by found on 21/02/25.
//
import SwiftUI

struct ConteudoView: View {
    
    var conteudo: Conteudo
    @Environment(\.dismiss) var dismiss
    
    @State private var paginaDeTexto: String
    init(conteudo: Conteudo) {
        self.conteudo = conteudo
        _paginaDeTexto = State(initialValue: conteudo.paginaDeTexto)
    }
    
    var body: some View {
        ZStack {
            //"Filtro" amarelo
            Color(hex: "FFFBEF")
                .ignoresSafeArea(.all)
                .allowsHitTesting(false)
            VStack {
                ScrollView{
                    TextField("Digite aqui...", text: $paginaDeTexto, axis: .vertical)
                }
            }
            .frame(alignment: .topLeading)
            .padding(16)
            .navigationBarBackButtonHidden(true)
            .navigationTitle(conteudo.nome)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { dismiss() }) {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(Color(hex: "00504C"))
                            Text("Conteúdos")
                                .tint(Color(hex: "00504C"))
                        }
                    }
                }
            }
        }
    }
}
