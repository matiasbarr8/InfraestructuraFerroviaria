import locomotoras.*
import vagones.*

class Deposito{
    const property formaciones = #{}
    const property locomotoras = #{}

    method conjuntoConElVagonMasPesado(unDeposito) {
        return unDeposito.formaciones().filter({f => f.vagonMasPesadoDeFormacion(f)})
    }

    method vagonMasPesadoDeFormacion(unaFormacion){
        return unaFormacion.max({f => f.pesoMaximo()})
    }

    method necesitaConductorExperimentado(){
        return formaciones.any({f => f.esFormacionCompleja(f)})
    }

    method esFormacionCompleja(unaFormacion) {
        return unaFormacion.size() > 8 || unaFormacion.pesoMaximoDeLaFormacion() > 80000
    }

    method agregarLocomotoraAUnaFormacion(unaLocomotora, unaFormacion) {
        if(not unaFormacion.puedeMoverse() && self.puedeAgregarseAFormacion(unaLocomotora,unaFormacion)){
            unaFormacion.add(unaLocomotora)
        }
    }

    method puedeAgregarseAFormacion(unaLocomotora,unaFormacion) {
      return unaLocomotora.sumaDelArrastre() >= unaFormacion.kilosDeEmpujeParaMoverse()
    }
}