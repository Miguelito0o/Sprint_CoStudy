//
//  DiasDaSemana.swift
//  CoStudyOficial
//
//  Created by found on 20/02/25.
//
enum DiaDaSemana: String, CaseIterable, Identifiable {
    case segunda = "Segunda-feira"
    case terca = "Terça-feira"
    case quarta = "Quarta-feira"
    case quinta = "Quinta-feira"
    case sexta = "Sexta-feira"

    var id: String { self.rawValue }
}

