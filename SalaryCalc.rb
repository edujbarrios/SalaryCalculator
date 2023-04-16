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

# Función para obtener la configuración del salario
def get_salary_config
  puts "Configuración del salario:"
  puts "Ingrese la tarifa por hora:"
  rate = gets.chomp.to_i
  puts "Ingrese la tarifa por hora extra:"
  ot_rate = gets.chomp.to_i
  puts "Ingrese el porcentaje de impuestos (%):"
  tax = gets.chomp.to_i

  return {
    rate: rate,
    ot_rate: ot_rate,
    tax: tax
  }
end

puts "Calculadora de salario por hora"
puts "Ingrese las horas trabajadas:"
hours = gets.chomp.to_i
puts "Ingrese las horas extra:"
overtime = gets.chomp.to_i

config = get_salary_config()

base_pay = calculate_base_pay(hours, config[:rate])
ot_pay = calculate_ot_pay(overtime, config[:ot_rate])
gross_pay = base_pay + ot_pay
tax_amount = calculate_tax(gross_pay, config[:tax])
net_pay = calculate_net_pay(gross_pay, config[:tax])

result = {
  hours: hours,
  rate: config[:rate],
  overtime: overtime,
  ot_rate: config[:ot_rate],
  tax: config[:tax],
  base_pay: base_pay,
  ot_pay: ot_pay,
  gross_pay: gross_pay,
  tax_amount: tax_amount,
  net_pay: net_pay
}

print_result(result)
