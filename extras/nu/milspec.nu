# vim:foldmethod=marker

# Usage:
# In your nu config file, add the following lines:
# ```nu
# use <path to milspec.nvim>/extras/nu/milspec.nu
# $env.config = ($env.config? | default {})
# $env.config.color_config = (milspec)
# ```

# color definitions {{{
const variants = {
  dark: {
    fg: "#ffffff"
    bg: "#1c2127"
    gray: "#c5cbd3"
    bgGray: "#404854"
    fgGray: "#d3d8de"
    core: "#111418"
    blue: "#8abbff"
    green: "#72ca9b"
    orange: "#fbb360"
    red: "#fa999c"
    vermilion: "#ff9980"
    rose: "#ff66a1"
    violet: "#d69fd6"
    indigo: "#bdadff"
    cerulean: "#68c1ee"
    turquoise: "#7ae1d8"
    forest: "#62d96b"
    lime: "#d4f17e"
    gold: "#fbd065"
    sepia: "#d0b090"
  }
  light: {
    fg: "#111418"
    bg: "#f6f7f9"
    gray: "#5f6b7c"
    bgGray: "#d3d8de"
    fgGray: "#404854"
    core: "#ffffff"
    blue: "#2d72d2"
    green: "#238551"
    orange: "#c87619"
    red: "#cd4246"
    vermilion: "#d33d17"
    rose: "#db2c6f"
    violet: "#9d3f9d"
    indigo: "#7961db"
    cerulean: "#147eb3"
    turquoise: "#00a396"
    forest: "#29a634"
    lime: "#8eb125"
    gold: "#d1980b"
    sepia: "#946638"
  }
}
# }}}

# fancy expected message
def 'expected make' [options: list<string>, --limit: int = 20] {
  let literals = $options | each { $"'($in)'" }
  let optionCount = $options | length

  if ($optionCount == 2) {
    $"Expected either: ($literals | str join ' or ')"
  } else if ($optionCount <= $limit) {
    $"Expected one of: ($literals | drop | str join ', ') or ($literals | last)"
  } else {
    $"Expected one of: ($literals | take $limit | str join ', '), or (($options | length) - $limit) more"
  }
}

export def main [
  variant: string = "dark",
  # Whether to use the dark or light variant of Milspec.
  --relative (-R)
  # Whether to use colors from green to red, to indicate:
  #   - boolean values
  #   - more recent to less recent datetime fields
  #   - smaller to larger filesizes
] {
  if not ($variant in ($variants | columns)) {
    error make {
      msg: "Error generating Milspc color config"
      label: {
        text: $"Invalid variant `($variant)`"
        span: (metadata $variant).span
      }
      help: (expected make ($variants | columns))
    }
    return
  }

  let colors = ($variants | get $variant)

  return {
    ### TABLE APPEARANCE ###
    separator: $colors.bgGray
    header: {
      fg: $colors.fg
      attr: b
    }
    # same as number
    row_index: $colors.orange
    # trailing text in cells
    leading_trailing_space_bg: {
      fg: $colors.green
      bg: $colors.bgGray
    }

    ### PROMPT ###
    # auto-suggest
    hints: $colors.gray
    search_result: {
      fg: $colors.bg
      bg: $colors.vermilion
    }

    ### STRINGS ###
    string: $colors.green
    # this also gets used for dictionary properties, like
    # > let x = { foo: "bar" }
    # > x.foo
    #     ^^^
    # ideally, this color should be `$colors.turquoise`
    shape_string: $colors.green
    shape_string_interpolation: $colors.rose

    ### OPERATORS ###
    # `( )` parens
    block: $colors.turquoise
    shape_block: $colors.turquoise
    # `..` range characters
    range: $colors.turquoise
    shape_range: $colors.turquoise
    # `&&` and literal `and`
    shape_and: $colors.turquoise
    # `||` and literal `or`
    shape_or: $colors.turquoise
    # mathematical operators
    shape_operator: $colors.turquoise
    # `{ || ... }` lambda
    shape_closure: $colors.turquoise
    # `|` pipe
    shape_pipe: $colors.turquoise
    # `out>`/`err>` redirection
    shape_redirection: $colors.turquoise
    # `[1, 2, 3]` brackets
    list: $colors.turquoise
    shape_list: $colors.turquoise
    # `[[1, 2] [3, 4]]` brackets
    shape_table: $colors.turquoise
    # `{ foo: "bar" }` dictionaries
    record: $colors.turquoise
    shape_record: $colors.turquoise

    ### NUMBERS & BOOLEANS ###
    binary: $colors.orange
    shape_binary: $colors.orange
    bool: {||
      if $relative {
        if $in {
          $colors.green
        } else {
          $colors.red
        }
      } else { $colors.orange }
    }
    shape_bool: $colors.orange
    float: $colors.orange
    shape_float: $colors.orange
    int: $colors.orange
    shape_int: $colors.orange

    ### SPECIAL INDICATORS ###
    filesize: { |el|
      if $relative {
        if $el < 1mb {
          $colors.green
        } else if $el < 10mb {
          $colors.gold
        } else if $el < 100mb {
          $colors.orange
        } else {
          $colors.red
        }
      } else {
        $colors.orange
      }
    }
    date: { || (date now) - $in |
      if $relative {
        if $in < 1hr {
          { fg: $colors.green, attr: b }
        } else if $in < 1day {
          $colors.gold
        } else if $in < 1wk {
          $colors.orange
        } else {
          $colors.red
        }
      } else {
        $colors.rose
      }
    }

    duration: $colors.rose
    shape_datetime: $colors.rose

    ### FILESYSTEM ###
    shape_directory: {
      fg: $colors.rose
      attr: u
    }
    shape_filepath: $colors.rose
    shape_globpattern: $colors.rose

    ### FUNCTIONS ###
    shape_external: $colors.blue
    shape_external_resolved: $colors.blue
    # arguments
    shape_externalarg: $colors.vermilion
    shape_flag: $colors.turquoise

    ### KEYWORDS ###
    shape_internalcall: $colors.violet
    shape_keyword: $colors.violet
    # keywords like `null`
    nothing: $colors.violet
    shape_nothing: $colors.violet

    shape_matching_brackets: {
      bg: $colors.bgGray
      attr: b
    }
    shape_signature: $colors.gold

    ### VARIABLES ###
    cell-path: $colors.cerulean
    shape_vardecl: $colors.fg
    shape_variable: $colors.turquoise

    ### SYNTAX ERROR INDICATORS ###
    shape_garbage: {
      fg: $colors.bg,
      bg: $colors.red,
      attr: b
    }

    ### UNDOCUMENTED, UNUSED COLORS ###
    shape_literal: { attr: n }
    shape_custom: { attr: n }
    shape_match_pattern: { attr: n }
    empty: { attr: n }
  }
}
