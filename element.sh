#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t -c"

ELEMENT_DATE(){
  if [[ -z $1 ]]
  then
    echo "Please provide an element as an argument."
  else
    if [[ ! $1 =~ ^[0-9]+$ ]]
    then
      if [[ $1 =~ ^[a-zA-Z]{1,2}$ ]]
      then
        SELECTED_ELEMENT_SYBL=$($PSQL "SELECT atomic_number,name,symbol,type,atomic_mass,melting_point_celsius,boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol = '$1'")
        if [[ -z $SELECTED_ELEMENT_SYBL ]]
        then
          echo "I could not find that element in the database."
        fi
      else
        SELECTED_ELEMENT_NAME=$($PSQL "SELECT atomic_number,name,symbol,type,atomic_mass,melting_point_celsius,boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name = '$1'")
        if [[ -z $SELECTED_ELEMENT_NAME ]]
        then
          echo "I could not find that element in the database."
        fi
      fi
    else
      SELECTED_ELEMENT_ATOMNUM=$($PSQL "SELECT atomic_number,name,symbol,type,atomic_mass,melting_point_celsius,boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = $1")
      if [[ -z $SELECTED_ELEMENT_ATOMNUM ]]
      then
        echo "I could not find that element in the database."
      fi
    fi
    if [[ $SELECTED_ELEMENT_ATOMNUM ]]
      then
      echo "$SELECTED_ELEMENT_ATOMNUM" | while read ATOMIC_NUM BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELT_POINT BAR BOIL_POINT
        do
          echo "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELT_POINT celsius and a boiling point of $BOIL_POINT celsius."
        done
    elif   [[ $SELECTED_ELEMENT_SYBL ]]
      then
      echo "$SELECTED_ELEMENT_SYBL" | while read ATOMIC_NUM BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELT_POINT BAR BOIL_POINT
        do
          echo "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELT_POINT celsius and a boiling point of $BOIL_POINT celsius."
        done
    elif [[ $SELECTED_ELEMENT_NAME ]]
      then
      echo "$SELECTED_ELEMENT_NAME" | while read ATOMIC_NUM BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELT_POINT BAR BOIL_POINT
        do
          echo "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELT_POINT celsius and a boiling point of $BOIL_POINT celsius."
        done
    fi
  fi
}

ELEMENT_DATE $1
