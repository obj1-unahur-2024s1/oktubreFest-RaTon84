class MarcaCerveza{	
	const property lupulo
	const pais
	const property precioDeVenta
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
	const property carpa
	method contenidoDeAlcohol(){return litros*marca.graduacionAlcohol()}
}

class Persona{
	var peso
	const property jarrasCompradas = []
	const property escuchaMusicaTradicional
	const nivelDeAguante
	const property pais
	
	method totalDeAlcohol(){return jarrasCompradas.sum({j=>j.contenidoDeAlcohol()})}
	
	method estaEbria(){return self.totalDeAlcohol()*peso > nivelDeAguante}
		
	method leGusta(cerveza){
		if(pais=="belgica")return cerveza.lupulo()>4
		else if(pais=="checo") return cerveza.graduacionAlcohol()>8
		else return true
	}
	
	method comprarCerveza(jarra){jarrasCompradas.add(jarra)}	
	
	method esPatriota(){return jarrasCompradas.all({j=>j.pais()==pais})}	
	/////////////ver resolucion
	method sonCompatibles(persona){
		return jarrasCompradas.asSet().intersection(persona.jarrasCompradas().asSet()).size()
			> jarrasCompradas.asSet().difference(persona.jarrasCompradas().asSet()).size()
	}
	
	method carpas(){return jarrasCompradas.map({j=>j.carpa()}).asSet()}
	
	method jarraAnteriror(i){return if(i==0) jarrasCompradas.first() else jarrasCompradas.get(i-1)}
	
	method estaEntrandoEnElVicio(){
		return (0..jarrasCompradas.size())
			.all({i=>jarrasCompradas.get(i)>=self.jarraAnteriror(i)})
	}	
}

class Carpa{
	var personas =[]
	const limiteGente
	var hayBandaParaTocar
	const cerveza
	var recargo = self.recargoFijo()
	
	method precioDeVenta(){return cerveza.precioDeVenta()+recargo}
	
	method recargoFijo(){return cerveza.precioDeVenta()*0.3}
	
	method recargoPorCatidad(){
		return if(personas.size()>=limiteGente/2){
			cerveza.precioDeVenta()*0.4
		}else cerveza.precioDeVenta()*0.25
	}
	
	method recargoPorEbriedad(){
		return if(personas.count({p=>p.estaEbria()})>=limiteGente*0.75){
			cerveza.precioDeVenta()*0.5
		}else cerveza.precioDeVenta()*0.2
	}
	
	method agregareprsona(persona){personas.add(persona)}
	
	method quiereEntrar(persona){
		return persona.leGusta(cerveza)&&
			persona.escuchaMusicaTradicional()==hayBandaParaTocar&&
			!persona.pais()=="alemania" && personas.size().even()==0
	}
	
	method dejaIngresar(persona){return personas.size()<limiteGente && !persona.estaEbria()}
	
	method puedeEntrar(persona){return self.quiereEntrar(persona) && self.dejaIngresar(persona)}
	
	method entre(persona){
		if(!self.puedeEntrar(persona)){
			self.error("no puede entrar esta persona")
		}
		personas.add(persona)
	}
	/////////////////ver resolucion
	method leSirva(persona,litrosJarra){
		const jarraNueva = new Jarra(litros=litrosJarra,marca=cerveza,carpa=self)
		if(personas.contains(persona)){
			self.error("no esta en la carpa la persona")
		}		
		persona.comprarCerveza(jarraNueva)		
	}
	
	method ebriosEmpedernidos(){personas.count({p=>p.jarrasCompradas().all({j=>j.litros()>=1})})}	
	
	method esHomogenea(){return personas.all({p=>p.pais()==personas.first().pais()})}
	
	method noSeLesSirvio(){	personas.filter({p=>p.jarrasCompradas().contains({j=>j.carpa()==self})})}
}



