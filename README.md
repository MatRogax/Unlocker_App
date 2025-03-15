# 📱 Nome do App

Bem-vindo ao **Nome do App**! 🚀  
Este aplicativo foi desenvolvido com Flutter e tem como objetivo proporcionar uma experiência fluida e intuitiva para os usuários.

## Telas

![Captura de tela do meu projeto](.assets/prints/tela_de_pesquisa)
![Captura de tela do meu projeto](.assets/prints/pagina_de_inicio)
![Captura de tela do meu projeto](.assets/prints/pagina_de_cadastro)
![Captura de tela do meu projeto](.assets/prints/tela_de_login)
![Captura de tela do meu projeto](.assets/prints/tela_de_compra)

## 🔥 Funcionalidades

- 🛍️ Listagem de produtos mais vendidos  
- 🔎 Barra de pesquisa eficiente  
- ✅ Validação de formulário para cadastro e login  
- 🎨 Interface moderna e responsiva  

## 🛠️ Tecnologias Utilizadas

- **Linguagem**: Dart  
- **Framework**: Flutter  
- **Pacotes**:  
  - `fluttertoast` → Exibição de notificações e mensagens  
  - `flutter_form_builder` → Construção de formulários flexíveis  
  - `form_builder_validators` → Validação de campos de formulário  
  - `google_fonts` → Uso de fontes personalizadas  

## 📂 Estrutura do Projeto

```bash
/lib
└── app
    ├── main.dart
    ├── app.module.dart
    └── modules
        ├── auth
        │   ├── login
        │   │   ├── pages
        │   │   │   └── login_page.dart
        │   │   ├── widgets
        │   │   │   ├── login_appbar_widget.dart
        │   │   │   ├── login_auth_widget.dart
        │   │   │   └── login_form_widget.dart
        │   ├── register
        │   │   ├── pages
        │   │   │   └── register_page.dart
        │   │   ├── widgets
        │   │   │   ├── register_appbar_widget.dart
        │   │   │   ├── register_auth_widget.dart
        │   │   │   └── register_formfield_widget.dart
        ├── ecommerce
        │   ├── navigation
        │   ├── product
        │   ├── search
        │   │   ├── pages
        │   │   │   └── search_page.dart
        │   │   ├── widgets
        │   ├── shop
        │   │   ├── pages
        │   │   │   └── shop_page.dart
        │   │   ├── widgets
        ├── home
        │   ├── pages
        │   │   └── home_page.dart
        │   ├── widgets
        │   │   └── home_appbar_widget.dart
└── utils
    ├── constants.dart
└── Widgets
    ├── app.carrousel.dart
