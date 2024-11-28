build-starship:
  #!/usr/bin/env nu
  echo "Building starship..."
  open ./extras/milspec.json
    | values
    | reduce --fold {} {|it, acc| 
        $acc | insert $"milspec_($it.variant)" (
          $it.colors
            | transpose key value
            | reduce --fold {} {|it, acc|
                $acc | insert $it.key $"#($it.value)"
              }
        )
      }
    | { "palettes": $in }
    | to toml
    | "# put these at the end of your starship config:\n\n" + $in
    | save -f ./extras/starship/config.toml

build: (build-starship)

default:
  just --list
