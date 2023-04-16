require_relative 'SalaryCalc.rb'

RSpec.describe "Salary calculator" do
  describe "calculate_base_pay" do
    it "calculates the base pay correctly" do
      expect(calculate_base_pay(40, 10)).to eq(400)
    end
  end

  describe "calculate_ot_pay" do
    it "calculates the overtime pay correctly" do
      expect(calculate_ot_pay(5, 15)).to eq(75)
    end
  end

  describe "calculate_tax" do
    it "calculates the tax correctly" do
      expect(calculate_tax(1000, 10)).to eq(100)
    end
  end

  describe "calculate_net_pay" do
    it "calculates the net pay correctly" do
      expect(calculate_net_pay(1000, 10)).to eq(900)
    end
  end

  describe "print_result" do
    it "prints the result correctly" do
      result = {
        hours: 40,
        rate: 10,
        overtime: 5,
        ot_rate: 15,
        tax: 10,
        base_pay: 400,
        ot_pay: 75,
        gross_pay: 475,
        tax_amount: 47.5,
        net_pay: 427.5
      }

      expect { print_result(result) }.to output(
        "Resultado:\n" +
        "Horas trabajadas: 40\n" +
        "Tarifa por hora: 10\n" +
        "Horas extra: 5\n" +
        "Tarifa por hora extra: 15\n" +
        "Impuestos (%): 10\n" +
        "Salario base: 400\n" +
        "Salario extra: 75\n" +
        "Salario bruto: 475\n" +
        "Impuestos a pagar: 47.5\n" +
        "Salario neto: 427.5\n"
      ).to_stdout
    end
  end
end
