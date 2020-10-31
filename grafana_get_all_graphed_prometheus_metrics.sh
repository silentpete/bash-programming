# First effort at only sending the metrics I've graphed with Grafana onto InfluxDB for long term storage

# Requirements
#   sqlite and jq
# What is my though process
#  get the dashboard
#  turn into json
#  remove everyline that doesn't have expr in it
#  capture every item with 1 to many underscores in the name, put a newline after each capture
#  remove everything in front of the underscore word
#  remove every line without an underscore
#  sort and unique
#  Then adjust for formatting for prometheus and spit out the line

# run the following from within the grafana container
sqlite3 /var/lib/grafana/grafana.db 'select data from dashboard' | jq '' | sed '/expr/!d' | sed -r 's/(\w+_\w+)/\1\n/g' | sed -r 's/.*(\b\w+_\w+\b).*/\1/' | sed -r '/\b\w+_\w+\b/!d' | sort -u | sed -r 's/$/\.\*\|/' | sed ':a;N;$!ba;s/\n//g' | sed 's/|$//'
