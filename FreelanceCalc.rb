require 'prawn'

# Función para calcular el salario base
def calculate_base_pay(hours, rate)
  return hours * rate
end

# Función para calcular el salario extra
def calculate_ot_pay(overtime, ot_rate)
  return overtime * ot_rate
end

# Función para calcular el impuesto a pagar
def calculate_tax(gross_pay, tax)
  return (gross_pay * tax) / 100
end

# Función para calcular el salario neto
def calculate_net_pay(gross_pay, tax)
  return gross_pay - calculate_tax(gross_pay, tax)
end

# Función para imprimir el resultado
def print_result(result)
  puts "Resultado:"
  puts "Horas trabajadas: #{result[:hours]}"
  puts "Tarifa por hora: #{result[:rate]}"
  puts "Horas extra: #{result[:overtime]}"
  puts "Tarifa por hora extra: #{result[:ot_rate]}"
  puts "Impuestos (%): #{result[:tax]}"
  puts "Salario base: #{result[:base_pay]}"
  puts "Salario extra: #{result[:ot_pay]}"
  puts "Salario bruto: #{result[:gross_pay]}"
  puts "Impuestos a pagar: #{result[:tax_amount]}"
  puts "Salario neto: #{result[:net_pay]}"
end

# Datos del usuario
puts "Datos del usuario"
puts "Ingrese su nombre:"
name = gets.chomp
puts "Ingrese su email de PayPal:"
paypal_email = gets.chomp
puts "Ingrese su tarifa por hora:"
hourly_rate = gets.chomp.to_f
puts "Ingrese el porcentaje de comisión de PayPal (%):"
paypal_fee_percent = gets.chomp.to_f

# Datos del trabajo realizado
puts "\nDatos del trabajo realizado"
puts "Ingrese el nombre del trabajo:"
job_name = gets.chomp
puts "Ingrese las horas trabajadas:"
hours = gets.chomp.to_f
puts "Ingrese el número de días de espera del pago:"
payment_delay_days = gets.chomp.to_i

# Cálculo del salario
base_pay = calculate_base_pay(hours, hourly_rate)
ot_pay = calculate_ot_pay(0, 0)
gross_pay = base_pay + ot_pay
tax_amount = calculate_tax(gross_pay, 0)
net_pay = calculate_net_pay(gross_pay, 0)

# Cálculo de la comisión de PayPal
paypal_fee = 0.0
if gross_pay > 0
  if gross_pay <= 500
    paypal_fee = gross_pay * 0.035 + 0.3
  elsif gross_pay <= 10000
    paypal_fee = gross_pay * 0.029 + 0.3
  else
    paypal_fee = gross_pay * 0.019 + 0.3
  end
  paypal_fee *= paypal_fee_percent / 100
end

# Cálculo del precio final y conversión a dólares
price_eur = gross_pay + tax_amount + paypal_fee
price_usd = price_eur * 1.22

# Generación del PDF
Prawn::Document.generate("#{name}_#{job_name}_invoice.pdf") do
  # Encabezado
  text "Factura de trabajo realizado por #{name}
Trabajo realizado: #{job_name}
Horas trabajadas: #{hours}
Tarifa por hora: #{hourly_rate}
Días de espera del pago: #{payment_delay_days}
"

#Detalles de pago
move_down 20
text "Detalles de pago:"
indent(20) do
text "Salario base: #{base_pay}€"
text "Salario extra: #{ot_pay}€"
text "Salario bruto: #{gross_pay}€"
text "Impuestos a pagar: #{tax_amount}€"
text "Comisión de PayPal: #{paypal_fee}€"
text "Precio final (en euros): #{price_eur}€"
text "Precio final (en dólares): #{price_usd}$"
end

#Pie de página
move_down 20
text "Gracias por su trabajo."
end

puts "\nSe ha generado la factura en PDF."
