class Persona{
  var formasDePago = []
  var formaFavorita
  const cosasAdquiridas = []
  var efectivo // ojo con esto, puede que lo tenga el metodo de pago efectivo
  var salarioFijo
  

  method efectivo() = efectivo 

  method comprar(medioDePago,cosa) {
    if(medioDePago.verificarCompra(self,cosa)){
      self.obtenerCompra(cosa)
      medioDePago.realizarCompra(self,cosa)
    }
  }

  method obtenerCompra(cosa) {
    cosasAdquiridas.add(cosa)
  }

  method descontarEfectivo(valor) {
    efectivo -= valor
  }

  method pagarCuotaMesSiguiente() {
    self.cobrarSalario()
    if(){

    }
  }

  method cobrarSalario() = salarioFijo
  
}

class Cosa {
  var precio

  method precio() = precio 
}

// class FormaDePago { // ver si hay que hacer un objeto
// }

object enEfectivo{

  method verificarCompra(usuario,cosa) = usuario.efectivo() >= cosa.precio()

  method realizarCompra(usuario,cosa) {
    usuario.descontarEfectivo(cosa.precio())
  }
}

class CuentaBancaria{
  var saldo
  const propietarios = []
  var tasaEstablecidaPorBanco
  var montoPermitido

  method montoPermitido() = montoPermitido

  method tasaEstablecidaPorBanco() = tasaEstablecidaPorBanco 

  method saldo() = saldo 

  method verificarCompra(usuario,cosa) {}

  method realizarCompra(usuario,cosa) {}
}

class TarjetaDeDebito inherits CuentaBancaria{

  override method verificarCompra(usuario,cosa) = saldo > cosa.precio() && self.verificarPropietario(usuario)

  method verificarPropietario(usuario) = propietarios.contains(usuario) 

  override method realizarCompra(usuario,compra) {
   self.debitarElMonto(compra.precio())
  }

  method debitarElMonto(valor) {
    saldo -= valor
  }

}

class TarjetaDeCredito inherits CuentaBancaria{

  var cantidadDeCuotas

  override method verificarCompra(usuario,cosa) =  cosa.precio() <= montoPermitido

  override method realizarCompra(usuario,cosa){
    usuario.pagarCuotaAlMesSiguiente(self.cuotaMensual(cosa))
  }

  method cuotaMensual(cosa) = self.valorTotalAPagar(cosa) / cantidadDeCuotas

  method valorTotalAPagar(cosa) = cosa.precio() * (1 + (tasaEstablecidaPorBanco/100))
}

// cuenta y la tarjeta son lo mismo
// pagar mes actual y mes anterior de lo que falto por pagar
// pagar cuota se paga con lo del efectivo y lo que cobro del sueldo

// class banco

// HACER 2 TEST, de una compra en cuotas y otro de un cobro de sueldo


// EL SALDO, ES EL EFECTIVO? El debito se paga con el saldo de la cuenta o con el efectivo? 
