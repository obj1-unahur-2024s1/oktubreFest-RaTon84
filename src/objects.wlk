class MarcaCerveza{	
	const property lupulo // gramos * lt
	const pais
	//const alcohol
	method graduacionAlcohol()
}

class Rubia inherits MarcaCerveza{
	override method graduacionAlcohol(){}
}

class Negra inherits MarcaCerveza{
	var graduacionReglamentaria
	override method graduacionAlcohol() = return graduacionReglamentaria
}

class Hofbrau inherits MarcaCerveza{
	var graduacionReglamentaria
	override method graduacionAlcohol() = return graduacionReglamentaria//*1.25
}

class Jarra{
	const property litros
	const property marca
	method contenidoDeAlcohol(){return litros*marca.graduacionAlcohol()}
}

class Persona{
	var peso
	const jarrasCompradas = []
	const property escuchaMusicaTradicional
	const nivelDeAguante
	const property pais
	
	method totalDeAlcohol(){
		return jarrasCompradas.sum({j=>j.contenidoDeAlcohol()})
	}
	
	method estaEbria(){
		return self.totalDeAlcohol()*peso > nivelDeAguante
	}
	
	method leGusta(cerveza){
		if(pais=="belgica")return cerveza.lupulo()>4
		else if(pais=="checo") return cerveza.graduacionAlcohol()>8
		else return true
	}	
}

class Carpa{
	var personas =[]
	const limiteGente
	var hayBandaParaTocar
	const cerveza
	//method venderJarraCerveza()
	
	method agregareprsona(persona){personas.add(persona)}
	
	method quiereEntrar(persona){
		return persona.leGusta(cerveza)&&
			persona.escuchaMusicaTradicional()==hayBandaParaTocar&&
			!persona.pais()=="alemania" && personas.size().even()==0
	}
	
	method dejaIngresar(persona){
		return personas.size()<limiteGente && !persona.estaEbria()

	}
	
	method puedeEntrar(persona){
		return self.quiereEntrar(persona) && self.dejaIngresar(persona)
	}
	
	method entre(persona){
		if(!self.puedeEntrar(persona)){
			self.error("no puede entrar esta persona")
		}
		personas.add(persona)
	}
	
	method leSirva(persona){
		if(personas.contains(persona)){
			self.error("no esta en la carpa la persona")
		}
		
	}
}

