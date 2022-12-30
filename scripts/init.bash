# (?<=Version: )"([0-9]+.[0-9]+.[0-9]+.[0-9]+)"
# (?<=_VERSION = ")([0-9]+.[0-9]+.[0-9]+.[0-9]+)(?=")

SLASH='/'
DOUBLE='"'

PathYowsup=/workspace/yowsup
PathYowsupEnv=$PathYowsup/yowsup/env
PathResources=/workspace/resources

cd $PathResources
python3 dexMD5.py whatsapp.apk >$PathResources/versions
version=$(grep -oP "(?<=Version: )(.*)" $PathResources/versions)
key=$(grep -oP '(?<=ClassesDex: )(.+)' $PathResources/versions)
echo "Version:  $version"
echo "Key:      $key"

sleep 2

cd $PathYowsupEnv

sed -i -E "s%(_VERSION = )(${DOUBLE}.*${DOUBLE})%\1${DOUBLE}${version}${DOUBLE}%" $PathYowsupEnv/env_android.py
sed -i -E "s%(_MD5_CLASSES = )(${DOUBLE}.*${DOUBLE})%\1${DOUBLE}${key}${DOUBLE}%" $PathYowsupEnv/env_android.py

cd $PathYowsup
python3 setup.py build
python3 setup.py install
