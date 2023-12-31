#!/bin/bash

echo "Bem vindo ao setup de instalação da GraphCar, para executar o script é necessário ser um sudoer"

permission=`id -u`

permissao=`echo $permission`

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

python3 --version

if [ $? = 0 ]
 then echo "Python já instalado"
	echo "Instalando as dependências do Python"
	sleep 3
	apt install python3-pip
 	pip install mysql-connector-python

	curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc

	curl https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list | sudo tee /etc/apt/sources.list.d/mssql-release.list

	sudo apt-get update
	sudo ACCEPT_EULA=Y apt-get install -y msodbcsql18

	echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc
	source ~/.bashrc
	sudo apt-get install -y unixodbc-dev


	pip install pyodbc
	pip install psutil
	pip install requests
 else 
	echo "Instalando o Python"
	sleep 1
	apt install apt-get install python3.10
	echo "Instalando o pip"
	sleep 1
	apt install python3-pip
	echo "Instalando pacotes do Python"
	sleep 2
	pip install mysql-connector-python

	curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc

	curl https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list | sudo tee /etc/apt/sources.list.d/mssql-release.list

	sudo apt-get update
	sudo ACCEPT_EULA=Y apt-get install -y msodbcsql18

	echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc
	source ~/.bashrc
	sudo apt-get install -y unixodbc-dev


	pip install pyodbc
	pip install psutil
	pip install requests


fi

ls C-GraphCar

if [ $? = 0 ]
 then echo "Diretório C-GraphCar já existe" && cd C-GraphCar/Dados && python3 capturarTodos.py && cd ..
 else git clone https://github.com/GraphCar/C-GraphCar.git && cd C-GraphCar/Dados && python3 capturarTodos.py && cd ..
fi
