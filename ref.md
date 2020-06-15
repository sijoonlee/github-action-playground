https://stackoverflow.com/questions/2437452/how-to-get-the-list-of-files-in-a-directory-in-a-shell-script


for entry in "$search_dir"/*.html
do
  echo "$entry"
done

ls $search_path | grep *.txt > filename.txt

find $(pwd) -maxdepth 1 -type f -not -path '*/\.*' | sort

find . -maxdepth 1 -type f -name '*.html' -not -path '*/\.*' | sed 's/^\.\///g' | sort