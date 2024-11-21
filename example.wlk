class Persona{
  var formasDePago = []
  var formaFavorita
  const cosasAdquiridas = []
  var efectivo

  method comprar(medioDePago,cosa) {
    // medioDePago.verificarCompra(cosa)
    // self.obtenerCompra(cosa)
    if(medioDePago.verificarCompra(cosa)){
      self.obtenerCompra(cosa)
      medioDePago.realizarCompra(self,cosa)
    }
  }

  method obtenerCompra(cosa) {
    cosasAdquiridas.add(cosa)
  }
}

// class FormaDePago { // ver si hay que hacer un objeto
// }

class EnEfectivo{

}

class CuentaBancaria{
  
}

class TarjetaDeDebito inherits CuentaBancaria{
}

class TarjetaDeCredito inherits CuentaBancaria{

}

// cuenta y la tarjeta son lo mismo
// pagar mes actual y mes anterior de lo que falto por pagar
// pagar cuota se paga con lo del efectivo y lo que cobro del sueldo

// class banco

// HACER 2 TEST, de una compra en cuotas y otro de un cobro de sueldo
