# Prueba Resuelve

API creada con la finalidad de resolver el reto de resuelve. 

[![Codacy Badge](https://app.codacy.com/project/badge/Grade/db16d8ec9fbd403ea4939f211fef4698)](https://www.codacy.com/manual/HeHuHdez/reto-resuelve?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=HeHuHdez/reto-resuelve&amp;utm_campaign=Badge_Grade)

## Requerimientos

- Ruby 2.6.5
- Rails 6.0.2
- Docker Community 2.2.0.5 (Opcional)

Este proyecto fue hecho con el framework the rails en su version 6.0.2 montado sobre ruby 2.6.5. Sin embargo, se agrega un dockerfile y un archivo para montarlo con docker-compose si asi se desea. 

## Instalación

Instalación de Ruby mediante RVM / RBENV, se usa el comando rvm o rbenv dependiendo de la herramienta previamente instalada:

```bash
# Instalar la versión que deseemos.
$ [rvm | rbenv] install 2.6.5

# Usar la versión instalada.
$ [rvm use | rbenv global ]  2.6.5
```

Configuración del proyecto:

```bash
# Clonar el repositorio del proyecto.
$ git clone git@github.com:HeHuHdez/resuelve-api-test.git

# Instalar la gema bundler.
$ gem install bundle

# Instalar las gemas necesarias del proyecto.
$ bundle
```

Para iniciar la aplicación:

```bash
$ rails s
# Iniciará el servicio de la API de manera local en el puerto 3000. 
```

## Docker

Se requiere tener instalado docker y docker compose. Para levantar el contenedor solo debe de ir a la carpeta raiz del proyecto y poner los siguientes comandos

```bash
$ docker-compose up
# Iniciará el proceso de creación del contenedor. Si se utiliza el contenedor en mas de una ocasion, en automatico se ejecuta el comando de bundle en caso de que haya actualizaciones de las gemas. 
```

Para verificar el funcionamiento, acceda a por navegador a:

```text
GET http://localhost:3000/api
# API de Prueba para Resuelve
```

## Desarrollo

Se utiliza guard para monitorear los cambios realizados en los archivos. 
```bash
$ bundle exec guard -p
# Iniciara a ejecutar el comando de spring rspec para ejecutar las pruebas en automatico de los archivos modificados 
```

Se recomienda utilizar rubocop como linter en la aplicacion predilecta de desarrollo. Para mas informacion puede dar click [aquì](https://rubocop.readthedocs.io/en/stable/integration_with_other_tools/)
## Testing

Si desea ejecutar las pruebas unitarias, en consola escriba:

```bash
spring rspec
```

## Rutas

Actualmente solo existen dos rutas. 

|URL|Metodo|Funciòn|
|---|---|---|
|*/api*|GET| Ruta de bienvenida y probar que el servidor este activo |
|*/api/payments*|POST| Ruta donde se recibe el JSON para calcular el salario final de los jugadores|

En el caso de la segunda ruta, para poder calcular el salario de los jugadores, se recibe [la lista de jugadores](https://github.com/resuelve/prueba-ing-backend#la-prueba) dentro de la llave `_json`. Esto es debido a que, en el caso de que sea el unico parametro, se puede omitir la llave y mandar el arreglo completo. 

En el caso de mandar un nuevo tabulador para el calculo de los salarios, se tiene que mandar el arreglo dentro de un objeto con la llave `new_team_tabulator`, como se puede ver en el archivo *spec/controllers/api/payments_controller_spec.rb*

## Producciòn

Si asi se desea se pueden hacer consultas a un servidor que se encuentra activo en heroku. 

```text
POST https://change_url.herokuapp.com/api/payments
```
