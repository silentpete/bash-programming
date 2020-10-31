#!/bin/bash
#reference https://stackoverflow.com/questions/22697688/how-to-cat-eof-a-file-containing-code/22698106
cat <<'EOF' >> filename.sh
#!/bin/bash

if [[ ! -f test ]]; then
   echo "blah"
fi
EOF
