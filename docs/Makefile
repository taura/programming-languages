mds   := index.md $(wildcard html/*.md) $(wildcard html/exam2024/*.md)
htmls := $(patsubst %.md,%.html,$(mds))

all : $(htmls)

$(htmls) : %.html : %.md
	uv run pandoc --filter scripts/filter.py $< -o $@
# --number-sections 

.DELETE_ON_ERROR:
