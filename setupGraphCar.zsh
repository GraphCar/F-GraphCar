
#!/usr/bin/env zsh
set -x

echo "Bem vindo ao setup de instalação da GraphCar, para fazer a instalação é necessário ser um sudoer!!"

permission=`id -u`
permissao=`echo $permission`
mysqlPasswd="Graph2023"

if [ $permissao = 0 ]
 then echo "Sudo confirmado"
 else echo "É necessário executar como sudo!" ; exit
fi

git --version

if [ $? = 0 ]
 then echo " git instalado"
 else brew install git
fi

java --version

if [ $? = 0 ]
 then echo "Java instalado"
 else brew install java
fi

npm --version

if [ $? = 0 ]
 then npm  install
 else brew install nodejs npm 
fi

ls E-GraphCar

if [ $? = 0 ]
 then echo "Diretório E-GraphCar já existe" ; cd E-GraphCar/ ; java -jar monitoramento.jar & ; cd ..
 else git clone https://github.com/GraphCar/E-GraphCar.git ; cd E-GraphCar ; java -jar monitoramento.jar & ; cd ..
fi

ls A-GraphCar

if [ $? = 0 ]
 then echo "Diretório A-GraphCar já existe, tentando efetuar execução do website" ;  cd A-GraphCar/
 else git clone --recurse-submodules https://github.com/GraphCar/A-GraphCar.git ; cd A-GraphCar ; git submodule foreach "(git checkout main; git pull)"
fi

mysql --version

if [ $? = 0 ]
 then  /usr/local/mysql/support-files/mysql.server status
  if [ $? = 0 ]
   then echo "O mysql já está rodando. Confirme se o banco de dados foi criado corretamente"
   else /usr/local/mysql/support-files/mysql.server start
  fi
 else sudo -H -u gu zsh -c "brew install mysql" ; /usr/local/mysql/support-files/mysql.server start
fi

npm install
npm run start
