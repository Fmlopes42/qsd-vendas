# README

* Style
  - Implementado o locastyle como estilo padrão do site.

* Application Layout

  - Para exibir mensagens utilizar flash[:classes_alerts_locastyle]
    Ex: flash[:success] = 'Ação feita com sucesso'
        flash[:danger] = 'Ocorreu um erro ao executar a ação'
        flash[:info] = 'Apenas uma informação qualquer'

  - Para atribuir Títulos ao Header e a Página utilizar helper content_for nas
    views. (header_title, page_title)
    Ex:
      <% content_for :header_title do %>
        Title to Header
      <% end %>


This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
