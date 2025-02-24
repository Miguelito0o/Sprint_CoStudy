//
//  Models.swift
//  CoStudyOficial
//
//  Created by found on 24/02/25.
//
import SwiftUI
import Foundation

struct Turma: Identifiable {
    let id = UUID()
    let codigo : String
    var nome: String
    var descricao: String
    var materias: [Materia] = []
    var eventos: [String] = []
    
    static func gerarCodigo() -> String {
        let length : Int = 6
        let caracteres = "abcdefghijkmnpqrstuvwxyz23456789"
        return String((0..<length).map { _ in caracteres.randomElement()! })
    }
}

struct Materia: Identifiable {
    let id = UUID()
    var nome: String
    var responsavel : String
    var topicos : [Topico]
}

struct Topico: Identifiable {
    let id = UUID()
    var nome : String
    var conteudos : [Conteudo]
}

struct Conteudo : Identifiable {
    let id = UUID()
    var nome : String
    var paginaDeTexto : String
}

enum DiaDaSemana: String, CaseIterable, Identifiable {
    case segunda = "Segunda-feira"
    case terca = "Terça-feira"
    case quarta = "Quarta-feira"
    case quinta = "Quinta-feira"
    case sexta = "Sexta-feira"

    var id: String { self.rawValue }
}
