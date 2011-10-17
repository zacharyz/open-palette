/*!
 * jQuery imagesLoaded plugin v1.0.4
 * http://github.com/desandro/imagesloaded
 *
 * MIT License. by Paul Irish et al.
 */
(function(a,b){a.fn.imagesLoaded=function(a){function g(){a.call(c,d)}function h(a){--e<=0&&a.target.src!==f&&(setTimeout(g),d.unbind("load error",h))}var c=this,d=c.find("img").add(c.filter("img")),e=d.length,f="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw==";return e||g(),d.bind("load error",h).each(function(){if(this.complete||this.complete===b){var a=this.src;this.src=f,this.src=a}}),c}})(jQuery)