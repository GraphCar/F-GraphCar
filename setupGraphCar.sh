#!/bin/bash

echo "Bem vindo ao setup de instalação da GraphCar, para executar o script é necessário ser um sudoer"

permission=`id -u`

permissao=`echo $permission`
`
if [ $permissao = 0 ]
 then echo "Sudo confirmado"
 else echo "É necessário executar como sudo" ; exit
fi

echo "Atualizando os pacotes do sistema"
sleep 2
apt upgrade && sudo apt update -y

echo "Verificando se o Git já está instalado"
git --version

if [ $? = 0 ]
 then echo "Git já instalado"
 else 
	echo "O Git não foi encontrado no sistema."
	echo "Deseja prosseguir com a instalação do Git? (S/N)"
	read inst
	if [ \"$inst\" == \"S\" ]
		then
			echo "Instalando o Git"
			sleep 2
			apt-get install git
	fi
fi

"Verificando se o NPM já está instalado"
npm -- version

if [ $? = 0 ]
 then "NPM já instalado"
 else 
	 echo "O NPM não foi encontrado no sistema."
		echo "Deseja prosseguir com a instalação do NPM? (S/N)"
		read inst
		if [ \"$inst\" == \"S\" ]
			then 
				echo "Instalando o NPM"
				sleep 2
				apt install nodejs npm -y
		fi
fi

java --version

if [ $? = 0 ]
 then echo "Java instalado"
 else apt install openjdk-17-jre-headless
fi

mysql --version

if [ $? = 0 ] 
 then /usr/local/mysql/support-files/mysql.server status
  if [ $? = 0  ]
   then echo "O mysql já está rodando"
   else echo "O servidor mysql está offline, iniciando" ; usr/local/mysql/support-files.mysql.server start
  fi
 else apt-get install -y mysql-server
fi

ls E-GraphCar

if [ $? = 0 ]
 then echo "Diretório C-GraphCar já existe" ; cd E-GraphCar/ ; java -jar monitoramento.jar & ; cd ..
 else git clone https://github.com/GraphCar/C-GraphCar.git ; cd C-GraphCar ; python3  & ; cd ..
fi

ls A-GraphCar

if [ $? = 0 ]
 then echo "Diretório A-GraphCar já existe, tentando efetuar execução do website" ; cd A-GraphCar/
 else git clone --recurse-submodules https://github.com/GraphCar/A-GraphCar.git ; cd A-GraphCar ; git submodule foreach "(git checkout main; git pull)"
fi

npm install
npm start
