class Persona{
  var formasDePago = []
  var formaFavorita
  const cosasAdquiridas = []
  var efectivo
  var salarioFijo
  var cuotasAPagar = []

  method cambiarFormaDepagoFavorita(formaDePago){
    formaFavorita = formaDePago
  }

  method efectivo() = efectivo

  method montoTotalCuotasPendientes() = cuotasAPagar.sum()

  method comprar(cosa) {
    if(formaFavorita.verificarCompra(self,cosa)){
      self.obtenerCompra(cosa)
      formaFavorita.realizarCompra(self,cosa)
    }
  }

  method obtenerCompra(cosa) {
    cosasAdquiridas.add(cosa)
  }

  method descontarEfectivo(valor) {
    efectivo -= valor
  }

  method pagarCuotaMesSiguiente(valor) {
    self.cobrarSalario()
    self.reducirTodasLasCuotasCorrespondientes(valor)
    if(salarioFijo > 0){
      self.guardarSalario()
    }
  }

  method reducirTodasLasCuotasCorrespondientes(valor){
    cuotasAPagar.map({cuota=>cuota.reducirMontoTotalDeCuotas(valor)})
  }
  
  method guardarSalario() {
    efectivo += salarioFijo
  }

  method cobrarSalario(){
    salarioFijo += salarioFijo
  }

  method restarSalario(valorCuota) {
    salarioFijo -= valorCuota
  }

  method agregarMontoTotalPendiente(monto) = cuotasAPagar.add(monto)
  
  method reducirMontoTotalDeCuotas(valor) {
    self.restarSalario(valor)
    }
}

class Cosa {
  var precio

  method precio() = precio 
}

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
    usuario.agregarMontoTotalPendiente(self.valorTotalAPagar(cosa))
    usuario.pagarCuotaAlMesSiguiente(self.cuotaMensual(cosa))
  }

  method cuotaMensual(cosa) = self.valorTotalAPagar(cosa) / cantidadDeCuotas

  method valorTotalAPagar(cosa) = cosa.precio() * (1 + (tasaEstablecidaPorBanco/100))
}

class TarjetaLocaDeDescuento inherits TarjetaDeCredito {
  var comprasRegistradas
  const descuentoExtraordinario
  
  override method realizarCompra(usuario,cosa) {
    super(usuario,cosa)
    self.aumentarRegistro()
    if(self.hacerDescuentoExcepcional()){
      self.aplicarDescuento(cosa)
    }
  }

  method hacerDescuentoExcepcional() = comprasRegistradas.sum() > 1000000 

  method aplicarDescuento(cosa) = self.valorTotalAPagar(cosa) - ((descuentoExtraordinario/100) * self.valorTotalAPagar(cosa))

  method aumentarRegistro() {
    comprasRegistradas += 1
  }
}

class CompradorCompulsivo inherits Persona{
  
  override method comprar(cosa) {
    super(cosa)
    if(not self.verificarCompraFueRealizada(cosa)){
      self.buscarOtraFormaDePago(cosa).forEach({forma=>forma.comprar(cosa)})
    }
  }

  method buscarOtraFormaDePago(cosa) {
    const formasAlternativas = formasDePago.filter({formaDePago=>formaDePago.verificarCompra(self, cosa)})
    return formasAlternativas
  }

  method verificarCompraFueRealizada(cosa) = cosasAdquiridas.contains(cosa)
}

class PagadorCompulsivo inherits Persona{
  
}
