<?php

class Parser {
  protected $html;
  public $tagsList;


  public function parseByURL($url) {
    $html = @file_get_contents(trim($url));

    if ($html) {
      $this->html = $html;
      $this->tagsList = $this->parseHTML($html);
    } else {
      echo "Url is not valid \n";
    }
  }

  protected function parseHTML($html) {
    $onTagName = false;
    $checkIfClosingTag = false;
    $tagName = '';
    $dict = [];

    // State variable which tell us if we're in script block
    $inScriptTag = false;


    for ($i = 0; $i < strlen($html); $i++) {

      // Skip all code till the end of script block
      if ($inScriptTag) {
        $restPartOfHTML = substr($html, $i);
        $strpos = strpos($restPartOfHTML, '</script>');
        
        $inScriptTag = false;
        $i += $strpos;
      }


      // Main logic block. Searching for tags
      // If we iterate through tag name now, check if we reached end of it's name
      if ($onTagName && ($html[$i] === '>' || $html[$i] === ' ')) {
        $dict[$tagName] += 1;

        if ($tagName === 'script') {
          $inScriptTag = true;
        }

        $tagName = '';
        $onTagName = false;

        // Check if current tag is comment-tag and immediately add it to list
        // Need this check if tag is comment cause comment line can be joined with '!--' part
      } elseif ($tagName === '!--') {
        $dict[$tagName] += 1;
        $tagName = '';
        $onTagName = false;

        // If we are not on tag name and faced '<' set flags 'onTagName' and 'checkIfClosingTag' to true
        // checkIfClosingTag is a flag which tell us check char after '<'. If it's a slash it's closing tag
        // and we don't count it
      } elseif (!$onTagName && $html[$i] === '<') {
        $onTagName = true;
        $checkIfClosingTag = true;

        // Check if closing tag. If it's - don't count it
      } elseif ($onTagName && $checkIfClosingTag) {
        if ($html[$i] === '/') {
          $checkIfClosingTag = false;
          $onTagName = false;
          // if char isn't slash start to memorize tag name
        } else {
          $checkIfClosingTag = false;
          $tagName .= $html[$i];
        }

        // if none of previous conditions triggered we're on tag name, memorize it
      } elseif ($onTagName) {
        $tagName .= $html[$i];
      }
    }

    return $dict;
  }

  public function __toString() {
    $result = array_map(function ($value, $key) {
      return "{$key}: {$value}";
    }, $this->tagsList, array_keys($this->tagsList));

    return implode($result, ', ') . "\n";
  }
}


echo "Enter url of web-site which you want to parse:\n";

$url = fgets(STDIN);
$parser = new Parser();

$parser->parseByURL($url);
// Use defined magic method __toString
echo $parser;

