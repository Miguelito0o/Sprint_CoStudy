//
//  Modais.swift
//  CoStudyOficial
//
//  Created by found on 11/02/25.
//
import SwiftUI


//Modal do botão de criar e entrar em turmas
struct ModalCriarEntrarView: View {
    
    @State var ModalCriarTurma = false
    @State var ModalEntrarTurma = false
    @State var codigo = ""
    @Binding var turmas : [Turma]
    @Binding var turmasTeste : [Turma]
    @Environment(\.dismiss) var dismiss
    
    var onCreate: (Turma) -> Void
    
    var body: some View {
        NavigationStack {
            VStack{
                Button(action: {
                    ModalCriarTurma = true
                }, label: {
                    ZStack{
                        Rectangle()
                            .foregroundColor(Color(hex:"298B87"))
                            .cornerRadius(15)
                            .foregroundStyle(.white)
                            .frame(width: 337 , height: 44)
                        HStack {
                            Text("Criar turma")
                                .foregroundStyle(.white)
                                .font(.headline)
                            
                            Spacer()
                            
                            Image(systemName: "plus.square")
                                .foregroundStyle(.white)
                                .font(.system(size: 20))
                        }
                        .padding(.horizontal, 20)
                    }
                    
                })
                .padding(.horizontal)
                .padding(.horizontal)
                
                
                
                Button(action: {
                    ModalEntrarTurma = true
                }, label: {
                    ZStack{
                        Rectangle()
                            .foregroundColor(Color(hex:"298B87"))
                            .cornerRadius(15)
                            .foregroundStyle(.white)
                            .frame(width: 337 , height: 44)
                        
                        HStack{
                            Text("Entrar em turma")
                                .foregroundStyle(.white)
                                .font(.headline)
                                .padding(.leading, 10)
                            
                            Spacer()
                            
                            Image(systemName: "person.3.fill")
                                .foregroundStyle(.white)
                                .font(.system(size: 20))
                            
                        }
                        .padding(.horizontal, 27)
                    }
                    
                })
                .padding(.horizontal)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
            }
        }
        
       
        .listStyle(.plain)
        .sheet(isPresented: $ModalEntrarTurma) {
            ModalEntrarTurmaView(turmas: $turmas, turmasTeste: $turmasTeste)
                .presentationDetents([.fraction(0.205)])
                .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $ModalCriarTurma) {
            ModalCriarTurmaView(onCreate: onCreate)
                .presentationDetents([.fraction(0.4)])
                .presentationDragIndicator(.visible)
        }
    }
}

//Modal do botão entrar em turma
struct ModalEntrarTurmaView: View {
    
    @State private var codigoDigitado: String = ""
    @Binding var turmas: [Turma]
    @Binding var turmasTeste: [Turma]
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        TextField("Digite aqui", text: $codigoDigitado)
                            .textInputAutocapitalization(.never)
                    } header: {
                        Text("Código da turma")
                    }
                }
                
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancelar") { dismiss() }
                    }
                    
                    ToolbarItem(placement: .confirmationAction) {
                        Button(action: {
                            if let turmaEncontrada = turmasTeste.first(where: { $0.codigo == codigoDigitado }) {
                                if !turmas.contains(where: { $0.codigo == turmaEncontrada.codigo }) {
                                    turmas.append(turmaEncontrada)
                                }
                                presentationMode.wrappedValue.dismiss()
                            }
                            
                        }, label: {
                                Text("Entrar")
                        })
                    }
                }
            }
        }
    }
    
}
    


//Modal do botão "Criar turma"
struct ModalCriarTurmaView: View {
    
    @State var nome: String = ""
    @State var descricao: String = ""
    @State var codigo: String = Turma.gerarCodigo()
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    
    var onCreate: (Turma) -> Void
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        TextField("Digite aqui", text: $nome)
                    } header: {
                        Text("Nome")
                    }
                    Section {
                        TextField("Digite aqui", text: $descricao)
                    } header: {
                        Text("Descrição")
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancelar") { dismiss()}
                    }
                    
                    ToolbarItem(placement: .confirmationAction) {
                        Button(action: {
                            let novaTurma = Turma(codigo: codigo, nome: nome, descricao: descricao)
                            onCreate(novaTurma)
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                                Text("Criar")
                        })
                    }
                }
            }
        }
    }
}

//Modal do botão de configurar turma
struct ModalConfigurarView: View {
    
   
    @State private var mostrarAlerta = false
    @State var ModalEditarTurma = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack { 
            VStack {
                Button(action: {
                    ModalEditarTurma = true
                }, label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color(hex: "298B87"))
                            .cornerRadius(15)
                            .frame(width: 337, height: 44)
                        Text("Editar turma")
                            .foregroundStyle(.white)
                            .font(.headline)
                    }
                })
                .padding()
                
                Button(action: {
                    mostrarAlerta = true
                }, label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color(hex: "298B87"))
                            .cornerRadius(15)
                            .frame(width: 337, height: 44)
                        Text("Excluir turma")
                            .foregroundStyle(.white)
                            .font(.headline)
                    }
                })
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
            }
        }
        .alert("Exclusão", isPresented: $mostrarAlerta) {
                        Button("Excluir", role: .destructive) {
                            
                        }
                        Button("Cancelar", role: .cancel) {
                            //Este botão apenas cancela :)
                        }
                    } message: {
                        Text("Você realmente deseja excluir a turma?")
                    }
        .presentationDragIndicator(.visible)
        .sheet(isPresented: $ModalEditarTurma) {
            ModalEditarTurmaView()
                .presentationDetents([.fraction(0.32)])
        }
    }
}

//Modal de edição de turma
struct ModalEditarTurmaView: View {
    @State private var nome: String = ""
    @State private var descricao: String = ""
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        TextField("Digite aqui", text: $nome)
                    } header: {
                        Text("Nome")
                    }
                    Section {
                        TextField("Digite aqui", text: $descricao)
                    } header: {
                        Text("Descrição")
                    }
                }
                .presentationDragIndicator(.visible)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Atualizar") {
                        
                    }
                }
            }
        }
        
    }
        
}

