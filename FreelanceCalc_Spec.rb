require_relative 'FreelanceCalc.rb' # El nombre del archivo de código a probar

RSpec.describe "Factura" do
  context "cuando se ingresan datos válidos" do
    let(:input) { StringIO.new("Juan\njuan@example.com\n15\n2\n7\n") } # Entrada simulada
    let(:output) { StringIO.new } # Salida simulada
    before do
      $stdin = input # Redireccionar entrada estándar
      $stdout = output # Redireccionar salida estándar
      generate_invoice # Llamar a la función principal
      $stdin = STDIN # Restaurar entrada estándar
      $stdout = STDOUT # Restaurar salida estándar
    end
    
    it "genera un PDF correctamente" do
      expect(File.exist?("Juan_trabajo1_invoice.pdf")).to be true # Verificar si el archivo PDF fue generado
    end
    
    it "imprime los detalles del pago correctamente" do
      expect(output.string).to include("Salario base: 30.0€")
      expect(output.string).to include("Salario extra: 0.0€")
      expect(output.string).to include("Salario bruto: 30.0€")
      expect(output.string).to include("Impuestos a pagar: 0.0€")
      expect(output.string).to include("Comisión de PayPal: 1.23€")
      expect(output.string).to include("Precio final (en euros): 31.23€")
      expect(output.string).to include("Precio final (en dólares): 38.07$")
    end
  end
  
  context "cuando se ingresan datos inválidos" do
    # Agrega casos de prueba para verificar cómo el código maneja entradas inválidas
  end
end
