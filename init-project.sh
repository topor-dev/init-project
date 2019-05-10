#!/usr/bin/env sh
script_dir=`dirname $(readlink -f "$0")`
template_dir="${script_dir}/template"

default_project_name="another-project"
year=`date "+%Y"`
readme_file='README.md'

if [ $# -gt 0 ]; then
	project_name="$1"
	echo "using \"${project_name}\" as project name"
else
	read -p "proeject name? [${default_project_name}]: " project_name
	project_name=${project_name:-${default_project_name}}
fi;


read -p "Copy template to \"${PWD}\" ?[y/n] " answer
case "${answer}" in
	y*|Y*) echo 'copying...' ;;
	*) echo "aborting"; exit 0 ;;
esac;


tmp_dir=`mktemp -d`

# make symbolic links of files
cp -rsT -- "${template_dir}" "${tmp_dir}"

(
	cd "${tmp_dir}"

	# update license year
	awk -v year="${year}" '/^Copyright/{$3=year};{print $0}' 'LICENSE' > 'LICENSE~' &&
		mv 'LICENSE~' 'LICENSE'

	# update project name in pyproject.toml:
	awk -v name="${project_name}" -F '"' '/name/{OFS="\"";$2=name}{print;OFS=" "}' 'pyproject.toml' > 'pyproject.toml~' &&
		mv 'pyproject.toml~' 'pyproject.toml'
	
	# generate readme
	echo "= ${project_name}" > "${readme_file}~" 
	mv "${readme_file}~" "${readme_file}"
)
cp -irLT -- "${tmp_dir}" "$PWD"
rm -rf -- "${tmp_dir}"
