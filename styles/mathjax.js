(function () {
  var newMathJax = 'https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.1/MathJax.js';
  var oldMathJax = 'cdn.mathjax.org/mathjax/latest/MathJax.js';
  var replaceScript = function (script, src) {
    var newScript = document.createElement('script');
    newScript.src = newMathJax + src.replace(/.*?(\?|$)/, '$1');
    newScript.onload = script.onload;
    newScript.onerror = script.onerror;
    script.onload = script.onerror = null;
    while (script.firstChild) newScript.appendChild(script.firstChild);
    if (script.id != null) newScript.id = script.id;
    script.parentNode.replaceChild(newScript, script);
    console.info('MathJax: 2.7.1.');
  }

  if (document.currentScript) {
    var script = document.currentScript;
    replaceScript(script, script.src);
  } else {
    var n = oldMathJax.length;
    var scripts = document.getElementsByTagName('script');
    for (var i = 0; i < scripts.length; i++) {
      var script = scripts[i];
      var src = (script.src || '').replace(/.*?:\/\//,'');
      if (src.substr(0, n) === oldMathJax) {
        replaceScript(script, src);
        break;
      }
    }
  }
})();
