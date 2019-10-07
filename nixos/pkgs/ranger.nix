{ stdenv, lib, fetchFromGitHub, python3Packages, file, less, highlight
, imagePreviewSupport ? true, w3m ? null}:

with stdenv.lib;

assert imagePreviewSupport -> w3m != null;

python3Packages.buildPythonApplication rec {
  name = "ranger-latest";

  src = fetchFromGitHub {
    owner = "ranger";
    repo = "ranger";
    rev = "807974ce63ba2db7c2e9705c59b54398420130fc";
    sha256= "0jbil1yg7pji50pg13h9pjw5jhhsknglm4djwxq0zfa7hqxqriiq";
  };

  LC_ALL = "en_US.UTF-8";

  checkInputs = with python3Packages; [ pytest ];
  propagatedBuildInputs = [ file ]
    ++ lib.optional (imagePreviewSupport) [ python3Packages.pillow ];

  checkPhase = ''
    py.test tests
  '';

  preConfigure = ''
    ${lib.optionalString (highlight != null) ''
      sed -i -e 's|^\s*highlight\b|${highlight}/bin/highlight|' \
        ranger/data/scope.sh
    ''}

    substituteInPlace ranger/data/scope.sh \
      --replace "/bin/echo" "echo"

    substituteInPlace ranger/__init__.py \
      --replace "DEFAULT_PAGER = 'less'" "DEFAULT_PAGER = '${stdenv.lib.getBin less}/bin/less'"

    for i in ranger/config/rc.conf doc/config/rc.conf ; do
      substituteInPlace $i --replace /usr/share $out/share
    done

  '' + optionalString imagePreviewSupport ''
    substituteInPlace ranger/ext/img_display.py \
      --replace /usr/lib/w3m ${w3m}/libexec/w3m

    # give image previews out of the box when building with w3m
    substituteInPlace ranger/config/rc.conf \
      --replace "set preview_images false" "set preview_images true"
  '';

  meta =  with lib; {
    description = "File manager with minimalistic curses interface";
    homepage = http://ranger.github.io/;
    license = licenses.gpl3;
    platforms = platforms.unix;
    maintainers = [ maintainers.toonn maintainers.magnetophon ];
  };
}
