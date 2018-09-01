select *
from apartments;

select distinct district
from apartments;

select count(*), district
from apartments
group by district
order by count(*) desc;

-- Vila Mariana, Jardim Paulista, Pinheiros, Bela Vista, Consolação, Higienópolis, Paraíso, Jardins, Aclimação, Cerqueira César, Jardim América, Jardim Europa, Chácara Klabin
-- Saúde, Vila Clementino, Santa Cecília, Centro, Liberdade, Jabaquara, Vila Guarani, Planalto Paulista, Sumaré, República

select *
from (select street, district, size, rooms, bathrooms, garages, rent, condo, rent + condo as total, code
      from apartments
      where district in ('Vila Mariana', 'Jardim Paulista', 'Pinheiros', 'Bela Vista', 'Consolação', 'Higienópolis', 'Paraíso', 'Jardins', 'Aclimação', 'Cerqueira César', 'Jardim América', 'Jardim Europa', 'Chácara Klabin'))
where total < 2500
order by size desc, total;

/*
https://www.vivareal.com.br/imovel/apartamento-3-quartos-vila-mariana-zona-sul-sao-paulo-80m2-aluguel-RS2000-id-1040322520/
https://www.vivareal.com.br/imovel/apartamento-2-quartos-consolacao-centro-sao-paulo-80m2-aluguel-RS1700-id-95007418/

https://www.vivareal.com.br/imovel/apartamento-2-quartos-aclimacao-centro-sao-paulo-com-garagem-135m2-aluguel-RS1800-id-94165180/
https://www.vivareal.com.br/imovel/apartamento-2-quartos-aclimacao-centro-sao-paulo-90m2-aluguel-RS1600-id-81828281/
https://www.vivareal.com.br/imovel/apartamento-2-quartos-bela-vista-centro-sao-paulo-85m2-aluguel-RS1600-id-95307110/
https://www.vivareal.com.br/imovel/apartamento-2-quartos-bela-vista-centro-sao-paulo-80m2-aluguel-RS1500-id-1037903508/
https://www.vivareal.com.br/imovel/apartamento-2-quartos-aclimacao-centro-sao-paulo-com-garagem-76m2-venda-RS330000-id-1038466150/
https://www.vivareal.com.br/imovel/apartamento-2-quartos-paraiso-zona-sul-sao-paulo-70m2-aluguel-RS1600-id-1038663042/
https://www.vivareal.com.br/imovel/apartamento-2-quartos-vila-mariana-zona-sul-sao-paulo-70m2-aluguel-RS1720-id-1039460617/
https://www.vivareal.com.br/imovel/apartamento-2-quartos-bela-vista-centro-sao-paulo-68m2-aluguel-RS1500-id-1039913716/
https://www.vivareal.com.br/imovel/apartamento-2-quartos-bela-vista-centro-sao-paulo-65m2-aluguel-RS1500-id-1037880264/
*/