#!/bin/bash

echo "Bem vindo ao setup de instalação da GraphCar, para executar o script é necessário ser um sudoer!!!"

permission=`id -u`

permissao=`echo $permission`
`
if [ $permissao = 0 ]
 then echo "Sudo confirmado"
 else echo "É necessário executar como sudo!" ; exit
fi

git --version

if [ $? = 0 ]
 then echo " git instalado"
 else apt-get install git
fi

npm -- version

if [ $? = 0 ]
 then npm  --install
 else apt install nodejs npm -y
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
 then echo "Diretório E-GraphCar já existe" ; cd E-GraphCar/ ; java -jar monitoramento.jar & ; cd ..
 else git clone https://github.com/GraphCar/E-GraphCar.git ; cd E-GraphCar ; java -jar monitoramento.jar & ; cd ..
fi

ls A-GraphCar

if [ $? = 0 ]
 then echo "Diretório A-GraphCar já existe, tentando efetuar execução do website" ; cd A-GraphCar/
 else git clone --recurse-submodules https://github.com/GraphCar/A-GraphCar.git ; cd A-GraphCar ; git submodule foreach "(git checkout main; git pull)"
fi

npm install
npm start
