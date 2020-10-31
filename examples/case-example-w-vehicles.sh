#!/bin/bash
# REF: https://bash.cyberciti.biz/guide/The_case_statement
# if no command line arg given
# set rental to Unknown
if [[ -z $1 ]]; then
  rental="*** Unknown vehicle ***"
elif [[ -n $1 ]]; then
# otherwise make first arg as a rental
  rental=$1
fi

# use case statement to make decision for rental
case $rental in
   "car") echo "For $rental rental, it is \$10 per mile.";;
   "van") echo "For $rental rental, it is \$20 per mile.";;
   "jeep") echo "For $rental rental, it is \$15 per mile.";;
   "bicycle") echo "For $rental rental, it is \$1 per mile.";;
   "cubetruck") echo "For $rental rental, it is \$25 per mile.";;
   "pickup") echo "For $rental rental, it is \$15 per mile.";;
   *) echo "Sorry, I can not get a $rental rental for you!";;
esac
