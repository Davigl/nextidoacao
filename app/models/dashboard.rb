class Dashboard
	def maior_hash_key(hash)
  		hash.max_by{|k,v| v}
	end

	def menor_hash_key(hash)
  		hash.min_by{|k,v| v}
	end

	def self.get_values_months(data)
		meses = []
		(1..12).each { |mes| meses << data.select("data_ocorrencia").where('extract(month from data_ocorrencia) = ? AND extract(year from data_ocorrencia) = ?', mes, Date.today.year).size }
		meses
	end

	def self.get_values_days(data)
		dias = []
		(0..6).each { |dia| dias << data.where('extract(dow from data_ocorrencia) = ?', dia).size}
		dias
	end

	def get_arrecadado (values)
		arrecadado = 0
		values.each { |cadastro| arrecadado += cadastro.valor }
		arrecadado
	end

	def percentual (cadastros_dia)
		return (cadastros_dia * 100) / 50
	end

	def percentual_liquido (arrecadado)
		return (arrecadado * 100) / 1000
	end
end