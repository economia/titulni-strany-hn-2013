/*! Echo v1.4.0 | (c) 2013 @toddmotto | MIT license | github.com/toddmotto/echo */
window.Echo = (function (window, document, undefined) {

  'use strict';

  var store = [],
    offset,
    throttle,
    poll = null,
    lastPoll = 0;

  var _inView = function (el) {
    var coords = el.getBoundingClientRect();
    return ((coords.top >= 0 && coords.left >= 0 && coords.top) <= (window.innerHeight || document.documentElement.clientHeight) + parseInt(offset));
  };

  var _pollImages = function () {
    lastPoll = new Date().getTime();
    for (var i = store.length; i--;) {
      var self = store[i];
      if (_inView(self)) {
        self.src = self.getAttribute('data-echo');
        store.splice(i, 1);
      }
    }
  };

  var _throttle = function () {
    var timeDiff = new Date().getTime() - lastPoll;
    if(poll === null && timeDiff > throttle) {
        _pollImages();
    } else {
        clearTimeout(poll);
        poll = null;
        poll = setTimeout(_pollImages, throttle - timeDiff);
    }
  };

  var init = function (obj) {
    var opts = obj || {},
        target = opts.target || window;


    offset = opts.offset || 0;
    throttle = opts.throttle || 250;
    rescan();

    if (document.addEventListener) {
      target.addEventListener('scroll', _throttle, false);
    } else {
      target.attachEvent('onscroll', _throttle);
    }
  };

  var rescan = function() {
    var nodes = document.querySelectorAll('[data-echo]');
    for (var i = 0; i < nodes.length; i++) {
      if(store.indexOf(nodes[i]) === -1) {
        store.push(nodes[i]);
      }
    }
    _throttle();
  }

  return {
    init: init,
    render: _throttle,
    rescan: rescan
  };

})(window, document);
