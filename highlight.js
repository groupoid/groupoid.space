function highlight() {
    var code = document.getElementsByTagName('code');
    for (var i = 0; i < code.length; i++) {
        code[i].innerHTML = code[i].innerHTML
            .replace(/([(){}→∀λ,=]+|::=|:=)/g,
                '<span class="h__symbol">$1</span>')
            .replace(/\b(data|where|module|import|Pi|Sigma|Path|split|let|in|U)\b(?!:)/g,
                '<span class="h__keyword">$1</span>');
    }
}

highlight();



var lastScrollPosition = 0;
var ticking = false;
window.addEventListener('scroll', function(e) {
    lastScrollPosition = window.scrollY;
    if (!ticking) {
        window.requestAnimationFrame(function() {
        doSomething(lastScrollPosition);
        ticking = false;
        });
    }
    ticking = true;
});

var titles = document.querySelector('.header__titles');
var logo = document.querySelector('.header__logo');
function doSomething(scrollPos) {
    titles.style.transform = 'translate3d(0px, ' + (scrollPos/2) + 'px, 0px)';
    logo.style.transform = 'translate3d(0px, ' + (scrollPos/2) + 'px, 0px)';
}
