//
//  EcomplexityEngine.swift
//  Test
//
//  Created by Román Mauricio Elias Valencia on 05/09/23.
//

import Foundation

struct EcomplexityEngine{
    var questionIndex = 0
    let questions = [Question(text: "Cuando algo me apasiona hago lo posible para lograr mis metas"),
    Question(text: "Cuando mi trabajo me apasiona hago lo posible por concluirlo, aunque enfrente circunstancias adversas, falta de tiempo o distractores"),
    Question(text: "A pesar del rechazo o problemas, siempre busco conseguir mis objetivos"),
    Question(text: "Soy tolerante ante situaciones ambiguas o que me generen incertidumbre"),
    Question(text: "Tengo la capacidad de establecer una meta clara y los pasos para lograrla"),
    Question(text: "Es común que logre convencer a otros sobre mis ideas y acciones"),
    Question(text: "Domino diferentes formas de comunicar mis ideas: por escrito, en un video o en charlas cara a cara"),
    Question(text: "Se me facilita delegar actividades a los miembros de mi equipo de acuerdo con sus perfiles"),
    Question(text: "Tengo la habilidad de identificar las fortalezas y debilidades de las personas con las que trabajo"),
    Question(text: "Se me facilita colaborar de manera activa en un equipo para lograr objetivos comunes."),
    Question(text: "Me apasiona trabajar en favor de causas sociales"),
    Question(text: "Creo que la misión de mi vida es trabajar para el cambio social y mejorar la vida de las personas"),
    Question(text: "Me interesa dirigir una iniciativa con resultados favorables para la sociedad y/o el medio ambiente"),
    Question(text: "Soy capaz de identificar problemas en el entorno social o ambiental para generar soluciones innovadoras"),
    Question(text: "Manifiesto un compromiso por participar en aspectos sociales de mi entorno"),
    Question(text: "Opino que el crecimiento económico debe ocurrir en igualdad de oportunidades y equidad para todos"),
    Question(text: "Mis acciones y comportamientos se rigen por normas morales basadas en el respeto y cuidado hacia las personas y a la naturaleza"),
    Question(text: "Sé cómo aplicar estrategias para crear nuevas ideas o proyectos"),
    Question(text: "Sé aplicar conocimientos contables y financieros para el desarrollo de un emprendimiento"),
    Question(text: "Tengo nociones sobre la logística para llevar a cabo la gestión de una organización"),
    Question(text: "Sé cómo realizar un presupuesto para lograr un proyecto"),
    Question(text: "Sé cómo establecer criterios de valoración y medir los resultados de impacto social"),
    Question(text: "Creo que el cometer errores nos ofrece nuevas oportunidades de aprendizaje"),
    Question(text: "Conozco estrategias para desarrollar un proyecto, aún con escasez de recursos"),
    
    //2da sección de preguntas
    
    Question(text: "Tengo la capacidad de encontrar asociaciones entre las variables, condiciones y restricciones en un proyecto"),
    Question(text: "Identifico datos de mi disciplina y de otras áreas que contribuyen a resolver problemas"),
    Question(text: "Participo en proyectos que se tienen que resolver utilizando perspectivas Inter/multidisciplinarias"),
    Question(text: "Organizo información para resolver problemas"),
    Question(text: "Me agrada conocer perspectivas diferentes de un problema"),
    Question(text: "Me inclino por estrategias para comprender las partes y el todo de un problema."),
    Question(text: "Tengo la capacidad de Identificar los componentes esenciales de un problema para formular una pregunta de investigación"),
    Question(text: "Conozco la estructura y los formatos para elaborar reportes de investigación que se utilizan en mi área o disciplina"),
    Question(text: "Identifico la estructura de un artículo de investigación que se maneja en mi área o disciplina"),
    Question(text: "Identifico los elementos para formular una pregunta de investigación"),
    Question(text: "Diseño instrumentos de investigación coherentes con el método de investigación utilizado"),
    Question(text: "Formulo y pruebo hipótesis de investigación"),
    Question(text: "Me inclino a usar datos científicos para analizar problemas de investigación."),
    Question(text: "Tengo la capacidad para analizar críticamente problemas desde diferentes perspectivas"),
    Question(text: "Identifico la fundamentación de juicios propios y ajenos para reconocer argumentos falsos"),
    Question(text: "Autoevalúo el nivel de avance y logro de mis metas para hacer los ajustes necesarios"),
    Question(text: "Utilizo razonamientos basados en el conocimiento científico para emitir juicios ante un problema"),
    Question(text: "Me aseguro de revisar los lineamientos éticos de los proyectos en los que participo."),
    Question(text: "Aprecio críticas en el desarrollo de proyectos para mejorarlos."),
    Question(text: "Conozco los criterios para determinar un problema"),
    Question(text: "Tengo la capacidad de identificar las variables, de diversas disciplinas, que pueden ayudar a responder preguntas"),
    Question(text: "Aplico soluciones innovadoras a diversas problemáticas"),
    Question(text: "Soluciono problemas interpretando datos de diferentes disciplinas"),
    Question(text: "Analizo problemas de investigación contemplando el contexto para crear soluciones?"),
    Question(text: "Tiendo a evaluar con sentido crítico e innovador las soluciones derivadas de un problema")]
    
    let parts = [Question(text: "Emprendedor Social"),
    Question(text: "Pensamiento Complejo")]
    var isSecondPart: Bool
    
    init(isSecondPart: Bool) {
            self.isSecondPart = isSecondPart
            if isSecondPart {
                questionIndex = 24 // Comienza en la pregunta 26 en la segunda parte
            }
        }

    
    func getText()->String{
        return questions[questionIndex].text
    }
    
    func getText2()->String{
        if questionIndex + 1 < 25{
            return parts[0].text
        }
        else{
            return parts[1].text
        }
    }
    
    func getProgress()->Float{
        let progress = Float(questionIndex+1)/Float(questions.count)
        return progress
    }
    
    mutating func nextQuestion() -> Bool {
        if questionIndex + 1 == 24 {
            questionIndex += 1
            return true
        } else if questionIndex + 1 < 48 {
            questionIndex += 1
            return false
        } else if questionIndex + 1 == 47 {
            return true
        } else {
            return true
        }
    }
}
