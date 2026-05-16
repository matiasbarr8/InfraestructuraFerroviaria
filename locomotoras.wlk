import vagones.*

class Locomotora {
  const property peso
  const property pesoAArrastrar
  const property velMaxima
  var esLocomotoraEficiente = false
  
  method esEficiente() {
    self.modificarEficiencia()
    return esLocomotoraEficiente
  }

  method modificarEficiencia() {
    if (self.esAlMenos5Veces()) {
        esLocomotoraEficiente = true
    } 
    else{
        esLocomotoraEficiente = false
    }
  }
  
  method esAlMenos5Veces() {
    return pesoAArrastrar >= (peso * 5)
  }  
}

class FormacionLocomotoras{
    const property locomotoras = new List()
    const property vagones = new List()

    method agregarLocomotora(unaLocomotora) {
        locomotoras.add(unaLocomotora)
    }
    
    method velocidadMaxima(){
        return locomotoras.min({l => l.velMaxima()}).velMaxima()
    }
    method esEficiente(){
        return locomotoras.all({l =>l.esEficiente()})
    }
    method puedeMoverse(){
        return self.sumaDelArrastre() >= self.pesoMaximoDeLaFormacion()
    }
    method pesoMaximoDeLaFormacion(){
        return self.pesoDeLosVagones() + self.pesoDeLasLocomotoras()
    }
    method sumaDelArrastre(){
        return locomotoras.sum({l => l.pesoAArrastrar()})
    }
    method pesoDeLosVagones(){
        return vagones.sum({v => v.pesoMaximo()})
    }
    method pesoDeLasLocomotoras(){
        return locomotoras.sum({l => l.peso()})
    }
    method kilosDeEmpujeParaMoverse(){
         
        if(self.puedeMoverse()){
            return 0
        }
        else{
            return 
            self.pesoMaximoDeLaFormacion() - self.sumaDelArrastre()
        }
    }
}