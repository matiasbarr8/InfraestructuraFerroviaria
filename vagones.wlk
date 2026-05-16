class VagonDePasajeros {
    const property largo 
    const property ancho 
    var property tieneBaño = false
    var property estaOrdenado = false
    var pasajeros = 0

    method esDePasajeros() = true
    method esDeCarga() = false
    method esDeDormitorio() = false

    method cantidadDePasajerosPorAncho() {
        if (self.ancho() <= 3) {
            pasajeros = 8 * self.largo()
        } else {
            pasajeros = 10 * self.largo()
        }
    }
    method cantidadDePasajeros() {
        self.cantidadDePasajerosPorAncho()
        if(estaOrdenado ){ 
            return pasajeros
        }else{
            return pasajeros - 15
        }
    }
    method capacidadMaximaDeCarga() {
        if (tieneBaño) {
            return 300
        } else {
            return 800
        }
    }
    method pesoMaximo() {
        return 2000 + (80 * self.cantidadDePasajeros()) + self.capacidadMaximaDeCarga()
    }
}

class VagonDeCarga {
    const cargaMaxima
    var property cantidadMaderasSueltas

    method capacidadMaximaDeCarga() {
        return cargaMaxima - (400 * cantidadMaderasSueltas)
    }

    method pesoMaximo() {
        return 1500 + self.capacidadMaximaDeCarga() 
    }

    method tieneBaño() = false

    method cantidadDePasajeros() = 0

    method arreglarMaderas() {
        cantidadMaderasSueltas = (cantidadMaderasSueltas - 2).max(0)
    }

    method esDePasajeros() = false
    method esDeCarga() = true
    method esDeDormitorio() = false
}

class VagonDeDormitorio {
    const property compartimientos
    const property camasEnCompartimientos

    method cantidadDePasajeros() {
        return compartimientos * camasEnCompartimientos
    }

    method tieneBaño() = true

    method capacidadMaximaDeCarga() = 1200

    method pesoMaximo() {
        return 4000 + (80 * self.cantidadDePasajeros()) + self.capacidadMaximaDeCarga()
    }

    method esDePasajeros() = false
    method esDeCarga() = false
    method esDeDormitorio() = true
}

class Formacion {
    const property vagones = new List()
    var property estaOrganizado

    method cantidadDePasajerosEnFormacion() {
        return vagones.sum({v => v.cantidadDePasajeros()})
    }

    method cantidadDeVagonesPopularesEnFormacion() {
        return vagones.count({v => v.cantidadDePasajeros() > 50})
    }

    method esCarguero() {
        return vagones.all({v => v.capacidadMaximaDeCarga() >= 1000})
    }

    method dispersionDePesos() {
        return self.vagonMasPesado() - self.vagonMasLiviano()
    }

    method vagonMasPesado() {
        return vagones.max({v => v.pesoMaximo()}).pesoMaximo()
    }

    method vagonMasLiviano() {
        return vagones.min({v => v.pesoMaximo()}).pesoMaximo()
    }

    method cantidadDeVagonesConBaño() {
        return vagones.count({v => v.tieneBaño()})
    }

    method mantenimiento() {
        self.mantenimientoAVagonDePasajeros()
        self.mantenimientoAVagonDeCarga()
    }

    method vagonesPasajeros() {
        return vagones.filter({v => v.esDePasajeros()})
    }

    method vagonesDeCarga() {
        return vagones.filter({v => v.esDeCarga()})
    }

    method mantenimientoAVagonDePasajeros() {
        self.vagonesPasajeros().forEach({v => v.estaOrdenado(true)})
    }

    method mantenimientoAVagonDeCarga() {
        self.vagonesDeCarga().forEach({v => v.arreglarMaderas()})
    }
    
    method estaEquilibrado() {
        return (self.vagonMasPesado().cantidadDePasajeros() - self.vagonMasLiviano().cantidadDePasajeros()) >= 20
    }

    method vagonPasajeroMasPesado() {
        return self.vagonesPasajeros().max({v => v.cantidadDePasajeros()})
    }

    method vagonPasajeroMasLiviano() {
        return self.vagonesPasajeros().min({v => v.cantidadDePasajeros()})
    }
}


