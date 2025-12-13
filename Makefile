install:
	pip install -r requirements.txt

data:
	gdown --folder "13esimLnLCGSs3k9tGdKrrAl9LjtBD9gH" -O data/

setup: install data