set -eu

export PYTHONUNBUFFERED=true

VIRTUALENV=.data/venv

# Periksa apakah python yang digunakan adalah python 3.9
if ! python3 --version | grep -q "3.9"; then
  echo "Python 3.9 is required. Please check your runtime environment."
  exit 1
fi

# Buat virtual environment jika belum ada
if [ ! -d $VIRTUALENV ]; then
  python3 -m venv $VIRTUALENV
fi

# Install pip jika belum ada
if [ ! -f $VIRTUALENV/bin/pip ]; then
  curl --silent --show-error --retry 5 https://bootstrap.pypa.io/get-pip.py | $VIRTUALENV/bin/python3
fi

# Install semua dependensi di requirements.txt
$VIRTUALENV/bin/pip install -r requirements.txt

# Jalankan aplikasi
$VIRTUALENV/bin/python3 app.py
