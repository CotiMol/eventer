Feature: Registración en evento

    @selenium
    Scenario: El formulario en inglés
        Given there is one event
        When I visit the "en" registration page
        Then I should see "More info!"
        And I should see "Where are you?"

    @selenium
    Scenario: El formulario en español
        Given there is one event
        When I visit the "es" registration page
        Then I should see "¡Me interesa!"
        And I should see "Tu lugar más próximo ..."

    @selenium
    Scenario: El formulario en idioma desconocido default a Inglés
        Given there is one event
        When I visit the "xx" registration page
        Then I should see "More info!"

    @selenium
    Scenario: El formulario sin lenguaje indicado
        Given there is one event
        When I visit the registration page without languaje
        Then I should see "¡Me interesa!"

    @selenium
    Scenario: Fechas en formulario en inglés
        Given there is one event 
        When I visit the "en" registration page
        Then I should see "Jan 31-Feb 01 from 09:00 to 18:00 hs."

    @selenium
    Scenario: Fechas en formulario en castellano
        Given there is one event
        When I visit the "es" registration page
        Then I should see "31 Ene-1 Feb de 09:00 a 18:00 hs."
