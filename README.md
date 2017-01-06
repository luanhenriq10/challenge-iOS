# challenge-iOS

Desafio https://github.com/stationfy/desafio-ios terminado.

Para rodar, baixe o projeto e use o comando:
# pod install

O .gitignore foi utilzado para realizar o commit da pasta Pods. Por ser apenas um gestor de dependencias.

Foi utilizado a API para comunicacao com server side chamada Alamofire. No projeto, foi criado uma extensão do Alamofire service, para uma melhor serialização
dos objetos, utilizando os Generics como principal fator.

Também foi utilizado o ObjectMapper para conversão de JSON -> Object.

Para o cache de imagens foi utilziado o AlamofireImage, framework próprio para download e cache de imagens em swift.
