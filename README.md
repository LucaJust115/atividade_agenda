# atividade_agenda (Leia até o final para dicas de como utilizar a aplicação)

## autor: Luca Mussi Just RGM: 802.569

Esta é uma aplicação simples de uma agenda simplificada feita em Flutter para gerenciar contatos, permitindo que os usuários adicionem, editem e removam informações de contato, como nome, telefone e email.

## Tecnologias Usadas

- Flutter
- Dart

## Funcionalidades

- **Cadastro de Contatos**: Permite adicionar novos contatos com nome, telefone e email.
- **Edição de Contatos**: Permite editar as informações de contatos existentes.
- **Remoção de Contatos**: Permite remover contatos da lista.
- **Listagem de Contatos**: Exibe todos os contatos cadastrados em uma lista.

## Estrutura do Projeto

O projeto é estruturado em três arquivos principais:

1. **`main.dart`**: Ponto de entrada do aplicativo, contendo a navegação principal entre as telas de cadastro e listagem de contatos.
2. **`contato_repository.dart`**: Contém a definição da classe `Contato` e `ContatoRepository` para gerenciar a lista de contatos.
3. **`cadastro.dart`**: Tela para adicionar e editar os contatos da agenda.
4. **`listagem.dart`**: Tela que exibe todos os contatos cadastrados na agenda.

## Como Executar o Projeto

1. **Clonar o Repositório**:
   ```bash
   git clone https://github.com/LucaJust115/atividade_agenda
   cd atividade_agenda

## Como Manusear o Aplicativo

1. Inicialmente, comece pelo botão cadastro e insira os dados que deseja.
2. Verifique que os dados estão compatíveis com os requisitos do aplicativo: Nome não pode estar vazio, Telefone deve ter 11 dígitos e conter apenas números e o email deve conter um '@' para identificar que se trata de um endereço de email
3. Após cadastrar, clique em salvar. (Caso deseje, pode clicar em voltar para cancelar o cadastro e retornar à página inicial)
4. Se desejar ver o cadastro realizado, volte e clique em listar.
5. Na tela de listagem estarão todos os dados do contato, se cadastrados corretamente.
6. No canto direito, ainda na tela de listagem, existe um menu 'três pontinhos' que contém as opções de editar ou remover o contato
7. Se optar por editar, clique no botão 'Salvar Edição', volte e liste novamente para ver o contato com as alterações.
8. Se optar por remover, basta clicar no botão apropriado que o contato será removido.
9. Desde que respeite os requisitos de cada um dos dados, pode cadastrar quantos contatos desejar.

