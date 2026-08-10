#!/bin/bash 

set -eu

echo topic=${topic}
echo problem=${problem}
echo user=${user}
echo lang=${lang}
echo skel_dir=${skel_dir}
echo submission_dir=${submission_dir}
echo out_dir=${out_dir}

if ! ls ${submission_dir}/note.md; then
    echo "no work" 1>&2
    exit 1
fi

# copy source file(s)
cp ${skel_dir}/../${problem}.md ${out_dir}/
cp ${submission_dir}/${problem}.${lang} ${out_dir}/
cp ${submission_dir}/${problem}.s ${out_dir}/
cp ${submission_dir}/note.md ${out_dir}/
cp ${submission_dir}/../comparison.md ${out_dir}/

wc ${out_dir}/note.md ${out_dir}/comparison.md

echo "===== ${out_dir}/note.md ====="
cat ${out_dir}/note.md

echo "===== ${out_dir}/comparison.md ====="
cat ${out_dir}/comparison.md
