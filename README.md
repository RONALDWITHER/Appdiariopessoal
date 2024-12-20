<h1>Life Log - Diário Pessoal</h1> 

<p align="center">
  <img alt="Static Badge" src="https://img.shields.io/badge/framework-blue?style=for-the-badge&logo=flutter&logoColor=blue&label=flutter&labelColor=black">
  <img alt="Static Badge" src="https://img.shields.io/badge/database-blue?style=for-the-badge&logo=firebase&logoColor=red&label=firebase&labelColor=black">
  <img alt="Static Badge" src="https://img.shields.io/badge/gradle-black?style=for-the-badge&logo=Gradle&logoColor=%2302303A">
  <img alt="Static Badge" src="https://img.shields.io/badge/3.7.0--232.0-blue?style=for-the-badge&logo=dart&logoColor=blue&label=dart&labelColor=black">
  <img alt="Static Badge" src="https://img.shields.io/badge/%3E50-blue?style=for-the-badge&label=testes&labelColor=black">
  <img alt="Static Badge" src="https://img.shields.io/badge/conclu%C3%ADdo-blue?style=for-the-badge&label=status&labelColor=black">
</p>

> Status do Projeto: :heavy_check_mark: :warning: (concluído)

### Tópicos 

:small_blue_diamond: [Descrição do projeto](#descrição-do-projeto)

:small_blue_diamond: [Funcionalidades](#funcionalidades)

:small_blue_diamond: [Layout da Aplicação](#layout-da-aplicação-dash)

:small_blue_diamond: [Pré-requisitos](#pré-requisitos)

:small_blue_diamond: [Como rodar a aplicação](#como-rodar-a-aplicação-arrow_forward)

## Descrição do Projeto 

<p align="justify">
  O Life Log é um diário digital completo para registrar e organizar sua vida de forma prática e criativa. Com ele, você pode:

Anotar pensamentos e momentos importantes em textos personalizados,
adicionar fotos para dar mais vida às suas lembranças,
criar lembretes e receber notificações, garantindo que suas metas e compromissos sejam sempre lembrados.
O Life Log é o lugar ideal para guardar suas memórias e manter sua rotina organizada, tudo em um único app intuitivo e elegante.
</p>

## Funcionalidades

:heavy_check_mark: Criar anotações

:heavy_check_mark: Adicionar imagens  

:heavy_check_mark: Criar lembretes  

## Layout da Aplicação :dash:

<p align="center">
  <img src="https://github.com/ErickDotZip/Quiz/blob/main/Life%20Log%20Tela%20de%20Login.jpeg?raw=true" alt="Tela de Login" width="200"/>
  <img src="https://github.com/ErickDotZip/Quiz/blob/main/Life%20Log%20Tela%20de%20Cadastro.jpeg?raw=true" alt="Tela de Cadastro" width="200"/>
  <img src="https://github.com/ErickDotZip/Quiz/blob/main/Life%20Log%20Recupera%C3%A7%C3%A3o%20de%20Senha.jpeg?raw=true" alt="Recuperação de Senha" width="200"/>
  <img src="https://github.com/ErickDotZip/Quiz/blob/main/Life%20Log%20Tela%20Inicial.jpeg?raw=true" alt="Tela Inicial" width="200"/>
  <img src="https://github.com/ErickDotZip/Quiz/blob/main/Life%20Log%20Tela%20de%20Anota%C3%A7%C3%B5es.jpeg?raw=true" alt="Tela de Anotações" width="200"/>
  <img src="https://github.com/ErickDotZip/Quiz/blob/main/Life%20Log%20Drawer.jpeg?raw=true" alt="Drawer" width="200"/>
  <img src="https://github.com/ErickDotZip/Quiz/blob/main/Life%20Log%20Calend%C3%A1rio.jpeg?raw=true" alt="Calendário" width="200"/>
</p>

... 
## Pré-Requisitos

:warning: [Node](https://nodejs.org/en/download/)

:warning: [Visual Studio Code](https://code.visualstudio.com)

:warning: [Flutter](https://www.flutter.dev) [Versão 3.24.5]

:warning: [Gradle](https://gradle.org)

:warning: [Java Development Kit](https://www.oracle.com/java/technologies/downloads/)

...
## Como rodar a aplicação :arrow_forward:

No terminal, clone o projeto: 

```
git clone https://github.com/RONALDWITHER/Appdiariopessoal.git
```
Após clonar, dê downgrade no Flutter até a versão [3.24.5] (Por motivo de bugs na nova versão [3.27.0] do Flutter):

```
flutter --versions
```
```
flutter downgrade
```

Após isso, aperte a tecla (F5) para rodar a aplicação

...
## Como rodar os testes :mag_right:

-Instale todos os componentes dos Pré-Requisitos

-Escolha o dispositivo de debug (Fortemente indicado um emulador Android)

Em seguida no terminal, cole o comando: 
```
flutter run
```

...
## Casos de Uso

- Cadastro de Usuário.

  Ator Principal: Usuário do app.

  Objetivo: Criar uma conta para começar a usar o Life Log.

  Fluxo Principal:

  1 - O usuário abre o aplicativo e seleciona a opção "Cadastrar".

  2 - Na tela de cadastro, insere seu nome de usuário, email e cria uma senha segura.
  
  3 - Confirma os dados e clica no botão "Registrar".

  4 - O sistema valida as informações e redireciona o usuário para a tela inicial.

...
## Linguagens, dependencias e libs utilizadas :books:

- [Flutter](https://www.flutter.dev) [Versão 3.24.5]
- [Dart](https://www.flutter.dev)
- [Firebase](https://firebase.google.com)
- [Gradle](https://gradle.org)

...
## Resolvendo Problemas :exclamation:

Para que o authentication com o Google fosse possível, foi necessário uma chave de acesso, o SHA-1, para consegui-la é necessário colocar o comando:

```
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
```

Para que seja executado com sucesso, é necessário baixar o Java Development Kit (JDK)

...
## Tarefas em aberto

:memo: Adição de notificações

...
## Desenvolvedores/Contribuintes :octocat:


| [<img src="https://avatars.githubusercontent.com/u/190425553?v=4" width=115><br><sub>Laila Nichole</sub>](https://github.com/nickSolia) |  [<img src="https://avatars.githubusercontent.com/u/165350183?v=4" width=115><br><sub>Jean Lucas</sub>](https://github.com/jeanPersil) |  [<img src="https://avatars.githubusercontent.com/u/160983221?v=4" width=115><br><sub>Erick Carvalho</sub>](https://github.com/ErickDotZip) | [<img src="https://avatars.githubusercontent.com/u/187022353?v=4" width=115><br><sub>Ronald Ribeiro</sub>](https://github.com/RONALDWITHER) | [<img src="https://avatars.githubusercontent.com/u/187021765?v=4" width=115><br><sub>Luís Felipe</sub>](https://github.com/felipekek) |
| :---: | :---: | :---: | :---: | :---:

## Licença 

[SENAI License](https://www.senaibahia.com.br)

Copyright :copyright: 2024 - Life Log
