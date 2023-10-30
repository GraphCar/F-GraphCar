# F-GraphCar

## Este é o repositório de instalação do ambiente Graph-Car
### O Script que deve ser executado na nuvem é o setupGraphCar.sh

#### O Script em zsh é feito para quesitos de compatibilidade e está em desenvolvimento, em uma futura versão ele executará os scripts do java e mysql automaticamente

## Fluxo do script
As primeiras duas linhas armazenam em uma variável o nível de permissão do usuário
E a próxima condicional verifica se o nível de permissão do é equivalente a um root (0)

A segunda condicional verifica se o git já está instalado e caso não esteja ele o instalará

A terceira condicional verifica se o node já está devidamente instalado e caso não esteja ele será instalado

A quarta condicional verifica se o java já está instalado e e caso não esteja efetua seu download

A quinta condicional verifica se o mysql já está instalado então ele prossegue para a próxima condicional
onde verifica se o serviço do mysql já está rodando, caso não esteja ele será iniciado

#### O script efetuará a instalação dos requisitos de acordo com as preferencias dos repositórios da sua distribuição (exceto o java que tem a versão openjdk-17-jre-headless
