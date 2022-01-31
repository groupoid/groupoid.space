function highlight() {
    var code = document.getElementsByTagName('code');
    for (var i = 0; i < code.length; i++) {
        code[i].innerHTML = code[i].innerHTML
            .replace(/([(){}→=]+|:|:=)/g,
                '<span class="h__symbol">$1</span>')
            .replace(/\b(data|transp|∀|Π|Σ|λ|glue|unglue|Glue|Anders|prover|MLTT|PTS|CCHM|HTS|deRham|hcomp|where|def|mutual|begin|end|module|import|option|false|true|indᵂ|sup|.1|.2|Σ|Π|Pi|Sigma|W|𝟎|𝟏|𝟐|ind₂|ind₁|ind₀|★|0₂|1₂|Path|PathP|Type|Prop|inductive|record|forall|fun|match|let|axiom|theorem|lemma|in|U|S|V)\b(?!:)/g,
                '<span class="h__keyword">$1</span>');
    }
}

highlight();

var lastScrollPosition = 0;
var ticking = false;

var titles = document.querySelector('.header__titles');
var logo = document.querySelector('.header__logo');
function doSomething(scrollPos) {
    titles.style.transform = 'translate3d(0px, ' + (scrollPos/2) + 'px, 0px)';
    logo.style.transform = 'translate3d(0px, ' + (scrollPos/2) + 'px, 0px)';
}
