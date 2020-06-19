# Ezmaster WebService for libpostal


## /parse-string.ini

Parse just one address

```bash
$ echo "Barboncino 781 Franklin Ave, Crown Heights, Brooklyn, NY 11238"|curl --no-buffer --data-binary @- "http://localhost:31976/parse-string.ini?indent=1"
[{
    "house": "barboncino",
    "house_number": "781",
    "road": "franklin ave",
    "suburb": "crown heights",
    "city_district": "brooklyn",
    "state": "ny",
    "postcode": "11238"
}]⏎
```

## /parse-strings.ini

Parse many addresses (one by line)

```bash
$ (cat <<EOF
Inist-CNRS 2, rue Jean Zay CS 10310 F-54519 Vandœuvre-lès-Nancy France
Barboncino 781 Franklin Ave, Crown Heights, Brooklyn, NY 11238
EOF
)|curl --no-buffer --data-binary @-  "http://localhost:31976/parse-strings.ini?indent=1"
```

## /expand-string.ini

Expand just one address

```bash
$ echo "Barboncino 781 Franklin Ave, Crown Heights, Brooklyn, NY 11238"|tee|curl --no-buffer --data-binary @- "http://localhost:31976/expand-string.ini"
["barboncino 781 franklin avenue crown heights brooklyn new york 11238"]
```


## /expand-strings.ini

Expand many addresses (one by line)

```bash
$ (cat <<EOF
Inist-CNRS 2, rue Jean Zay CS 10310 F-54519 Vandœuvre-lès-Nancy France
Barboncino 781 Franklin Ave, Crown Heights, Brooklyn, NY 11238
EOF
)|curl --no-buffer --data-binary @-  "http://localhost:31976/expand-strings.ini?indent=1"
["inist-cnrs 2, rue jean zay cs 10310 f-54519 vandoeuvre-les-nancy france",
"barboncino 781 franklin avenue crown heights brooklyn new york 11238"]
```

