<?
/** ----------------------------------------------------------------------------
    Converts messages.php definitions into the JS files for client-side
    internationalized messages.
 */

    // full run
    $langs_all         = array( 'en', 'nl', 'fr', 'de', 'es', 'it', 'sv', 'pl', 'da', 'ru' );
    $brands_regexp_all = '.*';

    // default run
    $langs             = array( 'en', 'nl', 'fr', 'de', 'ru' );
    $brands_regexp     = 'dflt';

    if ( isset( $argv[1] ) ){
        if ( $argv[1] == 'all' ){
            $langs         = $langs_all;
            $brands_regexp = '.*';
        } else {
            $brands_regexp = $argv[1];
        }
    }

    //$tmbase = getenv( 'TMBASE' );
    //require_once "../$tmbase/includes/messages.php";

    $tmbase = getenv( 'TMBASE' );
    $project_path = getenv( 'PROJECT_PATH' );
    require_once "$project_path/$tmbase/includes/messages.php";

    // extract the language-dependent version
    function LangExtract( $text, $language )
    {
        $lng = 'en';
        $comment = array();
        $text = explode( "\n", $text );
        foreach ( $text as $value ){
            $i = strpos( $value, '=' );
            if ( $i == 2 ){
                $lng = substr( $value, 0, $i );
                $value = substr( $value, $i+1 );
            }
            if ( !isset( $comment[$lng] ) ){
                $comment[$lng] = $value;
            } else {
                $comment[$lng] .= "\n" . $value;
            }
        }

        $text = null;
        if ( isset( $comment[$language] ) ){
            $text = $comment[$language];
        } else
        if ( isset( $comment['en'] ) ){
            $text = $comment['en'];
        } else {
            // $text = "!no_{$language}_msg!";
        }

        // trim one end \n
        $n = strlen( $text );
        if ( ($n > 0) && ($text[$n-1] == "\n") ){
            $text = substr( $text, 0, $n-1 );
        }
        return ( $text );
    }

    function ProcessVars( $vars, $outfile )
    {
        global $langs, $MESSAGES, $other_repl, $cyr_chars;

        foreach ( $langs as $lang )
        {
            $out_vars = array();
            $encoding = LangExtract( $MESSAGES[99], $lang );
            foreach ( $vars as $var )
            {
                $res = array();
                echo "  === processing $var for $lang\n";
                foreach ( $GLOBALS[$var] as $key => $msg )
                {
                    if ( is_array( $msg ) ){
                        echo "!!!!$key is array\n";
                    } else {
                        $res[$key] = iconv( $encoding, 'UTF-8', LangExtract( $msg, $lang ) );
                    }
                }
                ksort( $res );
                $out_vars[] = "var $var =\n" . preg_replace( '#(,"\d+":|,"~[A-Za-z][A-Z_a-z0-9]*~":)#m', "\n$1", json_encode( $res ) ) . ";\n";
            }

            // prepare JS
            $out_vars = implode( '', $out_vars );
            if ( $lang == 'ru' )    $out_vars = str_replace( array_keys( $cyr_chars ), array_values( $cyr_chars ), $out_vars );
            $out_vars = str_replace( array_keys( $other_repl ), array_values( $other_repl ), $out_vars );
            $out_file = str_replace( '%lang%', $lang, $outfile );

            // create folder, if not exists
            $dir = dirname( $out_file );
            if ( !file_exists( $dir ) ){
                @mkdir( $dir, 0777, true );
            }
            file_put_contents( $out_file, $out_vars );
        }
    }

    $cyr_chars = array(
        '\u0430' => 'а', '\u0410' => 'А',
        '\u0431' => 'б', '\u0411' => 'Б',
        '\u0432' => 'в', '\u0412' => 'В',
        '\u0433' => 'г', '\u0413' => 'Г',
        '\u0434' => 'д', '\u0414' => 'Д',
        '\u0435' => 'е', '\u0415' => 'Е',
        '\u0451' => 'ё', '\u0401' => 'Ё',
        '\u0436' => 'ж', '\u0416' => 'Ж',
        '\u0437' => 'з', '\u0417' => 'З',
        '\u0438' => 'и', '\u0418' => 'И',
        '\u0439' => 'й', '\u0419' => 'Й',
        '\u043a' => 'к', '\u041a' => 'К',
        '\u043b' => 'л', '\u041b' => 'Л',
        '\u043c' => 'м', '\u041c' => 'М',
        '\u043d' => 'н', '\u041d' => 'Н',
        '\u043e' => 'о', '\u041e' => 'О',
        '\u043f' => 'п', '\u041f' => 'П',
        '\u0440' => 'р', '\u0420' => 'Р',
        '\u0441' => 'с', '\u0421' => 'С',
        '\u0442' => 'т', '\u0422' => 'Т',
        '\u0443' => 'у', '\u0423' => 'У',
        '\u0444' => 'ф', '\u0424' => 'Ф',
        '\u0445' => 'х', '\u0425' => 'Х',
        '\u0446' => 'ц', '\u0426' => 'Ц',
        '\u0447' => 'ч', '\u0427' => 'Ч',
        '\u0448' => 'ш', '\u0428' => 'Ш',
        '\u0449' => 'щ', '\u0429' => 'Щ',
        '\u044a' => 'ъ', '\u042a' => 'Ъ',
        '\u044b' => 'ы', '\u042b' => 'Ы',
        '\u044c' => 'ь', '\u042c' => 'Ь',
        '\u044d' => 'э', '\u042d' => 'Э',
        '\u044e' => 'ю', '\u042e' => 'Ю',
        '\u044f' => 'я', '\u042f' => 'Я'
    );
    $other_repl = array(
        '\/'     => '/'
    );

//    foreach ( $cyr_chars as $key => $val ){
//        $cyr_chars[$key] = iconv( 'Windows-1251', 'UTF-8', $val );
//    }

    // process MACROS separately
    $macroses = $MACROS;
    foreach ( $macroses as $ckey => $macs )
    {
        if ( !preg_match( "/^($brands_regexp)$/i", $ckey ) )    continue;

        echo "\n  ======= processing MACROS for $ckey\n";
        // unwind parents chain
        $parents_chain = array( $ckey => 1 );
        $m = $ckey;
        while ( isset( $macroses[$m]['parent'] ) ){
            $m = $macroses[$m]['parent'];
            if ( !isset( $parents_chain[$m] ) )    $parents_chain[$m] = 1;
        }
        $parents_chain = array_keys( $parents_chain );
        $MACROS = array();
        while ( ( $m = array_pop( $parents_chain ) ) )
        {
            $MACROS = array_merge( $MACROS, $macroses[$m] );
        }
        unset( $MACROS['parent'] );

        ProcessVars( array( 'MACROS' )
                   , "$project_path/$tmbase/_gen/$ckey/macros.%lang%.js"
                   );
    }

    echo "\n  ======= processing other variables\n";
    ProcessVars( array( 'MESSAGES', 'all_currencies' )
               , "$project_path/$tmbase/_gen/app/messages.%lang%.js"
               );
