
class CentroKinesio{
	var property aparatos
	var property pacientes
	
	method coloresDeAparatos(){
		return aparatos.map({e=>e.color()}).asSet()
	}
	method pacientesChicos(){
		return pacientes.filter({e=>e.edad()<8})
	}
	method noPuedenCumplirRutina(){
		return pacientes.count({e=>not e.puedeRealizarRutina()})
	}
	
}

class Paciente{
	var property edad
	var property fortaleza
	var property dolor
	var property rutina 
	
	method usarAparato(unAparato){
		dolor-=unAparato.efectoAnalgesico(self)
		fortaleza+=unAparato.efectoMuscular(self)
	}
	
	method puedeUsarAparato(unAparato){
		return unAparato.puedeUsarlo(self)
	}
	
	method puedeRealizarRutina(){
		return rutina.all({e=>self.puedeUsarAparato(e)})
	}
	method realizarRutina(){
		if(self.puedeRealizarRutina()){
		rutina.forEach({e=>self.usarAparato(e)})
	}else{
		self.error("No puede realizarla")}
	
	}
}
class Resistente inherits Paciente{
	
	override method realizarRutina(){
		rutina.forEach({e=>self.usarAparato(e)})
		fortaleza+= rutina.size()
	} 
	
}

class Caprichoso inherits Paciente{

	method hayAparatoRojo(){
		return rutina.any({e=>e.color()==rojo.color()})
}
	override method puedeRealizarRutina(){
		return rutina.all({e=>self.puedeUsarAparato(e)})and
			   self.hayAparatoRojo()		
	}
	override method realizarRutina(){
		if(self.puedeRealizarRutina()){
		rutina.forEach({e=>self.usarAparato(e)})
		rutina.forEach({e=>self.usarAparato(e)})
	}else{
		self.error("No puede realizarla")}
	}

}

class RapidaRecuperacion inherits Paciente{
	
	override method realizarRutina(){
		rutina.forEach({e=>self.usarAparato(e)})
		dolor-=nivelDolor.decrementa()
	}
	
}

class Aparato{
	var property color=blanco
	
	method puedeUsarlo(unPaciente)
	
	method efectoMuscular(unPaciente)
	
	method efectoAnalgesico(unPaciente)
}


class Magneto inherits Aparato{
	
	override method puedeUsarlo(unPaciente){
		return true
	}
	override method efectoAnalgesico(unPaciente){
		return unPaciente.dolor()*0.1
	}
	override method efectoMuscular(unPaciente){
		return 0
	}
	
	
	
}
class Bicicleta inherits Aparato{
	
	override method puedeUsarlo(unPaciente){
		return unPaciente.dolor()<20
	}
	override method efectoAnalgesico(unPaciente){
		return 4
	}
	override method efectoMuscular(unPaciente){
		return 3
	}
	
}

class Minitramp inherits Aparato{
	
	override method puedeUsarlo(unaPersona){
		return unaPersona.edad()>8
	}
	override method efectoMuscular(unPaciente){
		return unPaciente.edad()*0.1
	}
	override method efectoAnalgesico(unPaciente){
		return 0
	}		
}



object blanco{
	method color(){return self}
}
object negro{
	method color(){return self}
}
object azul{
	method color(){return self}
}
object verde{
	method color(){return self}
}
object rojo{
	method color(){return self}
}


object nivelDolor{
	var valor=3
	
	method cambiarValor(unValor){
		valor=unValor
	} 
	
	method decrementa(){return valor}
}






