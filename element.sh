#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# Función para obtener la información de un elemento
GET_ELEMENT_INFO() {
  local ATOMIC_NUMBER=$1
  local ELEMENT_NAME ELEMENT_SYMBOL ELEMENT_TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT
  
  # Obtener información del elemento
  ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
  ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
  ELEMENT_TYPE=$($PSQL "SELECT type FROM types WHERE type_id = (SELECT type_id FROM properties WHERE atomic_number = $ATOMIC_NUMBER)")
  ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
  BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")

  # Mostrar la información si el elemento existe
  if [[ -n $ELEMENT_NAME ]]; then
    echo "The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  else
    echo "I could not find that element in the database."
  fi
}

# Verificar si se pasó un argumento
if [[ -z $1 ]]; then
  echo "Please provide an element as an argument."
else
  # Si el argumento es un número (atomic number)
  if [[ "$1" =~ ^[0-9]+$ ]]; then
    GET_ELEMENT_INFO "$1"
  
  # Si el argumento es un símbolo (1 o 2 letras)
  elif [[ "$1" =~ ^[A-Za-z]{1,2}$ ]]; then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1'")
    if [[ -n $ATOMIC_NUMBER ]]; then
      GET_ELEMENT_INFO "$ATOMIC_NUMBER"
    else
      echo "I could not find that element in the database."
    fi

  # Si el argumento es un nombre de elemento
  elif [[ "$1" =~ ^[A-Za-z]+$ ]]; then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$1'")
    if [[ -n $ATOMIC_NUMBER ]]; then
      GET_ELEMENT_INFO "$ATOMIC_NUMBER"
    else
      echo "I could not find that element in the database."
    fi
  fi
fi
