var EvPNG = {
    ns: 'EvPNG',
    imgSize: {},
    createVmlNameSpace: function() {
        if (document.namespaces && !document.namespaces[this.ns]) {
            document.namespaces.add(this.ns, 'urn:schemas-microsoft-com:vml')

        }
        if (window.attachEvent) {
            window.attachEvent('onbeforeunload', 
            function() {
                EvPNG = null

            })

        }

    },
    createVmlStyleSheet: function() {
        var a = document.createElement('style');
        document.documentElement.firstChild.insertBefore(a, document.documentElement.firstChild.firstChild);
        var b = a.styleSheet;
        b.addRule(this.ns + '\\:*', '{behavior:url(#default#VML)}');
        b.addRule(this.ns + '\\:shape', 'position:absolute;');
        b.addRule('img.' + this.ns + '_sizeFinder', 'behavior:none; border:none; position:absolute; z-index:-1; top:-10000px; visibility:hidden;');
        this.styleSheet = b

    },
    readPropertyChange: function() {
        var a = event.srcElement;
        if (event.propertyName.search('background') != -1 || event.propertyName.search('border') != -1) {
            EvPNG.applyVML(a)

        }
        if (event.propertyName == 'style.display') {
            var b = (a.currentStyle.display == 'none') ? 'none': 'block';
            for (var v in a.vml) {
                a.vml[v].shape.style.display = b

            }

        }
        if (event.propertyName.search('filter') != -1) {
            EvPNG.vmlOpacity(a)

        }

    },
    vmlOpacity: function(a) {
        if (a.currentStyle.filter.search('lpha') != -1) {
            var b = a.currentStyle.filter;
            b = parseInt(b.substring(b.lastIndexOf('=') + 1, b.lastIndexOf(')')), 10) / 100;
            a.vml.color.shape.style.filter = a.currentStyle.filter;
            a.vml.image.fill.opacity = b

        }

    },
    handlePseudoHover: function(a) {
        setTimeout(function() {
            EvPNG.applyVML(a)

        },
        1)

    },
    fix: function(a) {
        var b = a.split(',');
        for (var i = 0; i < b.length; i++) {
            this.styleSheet.addRule(b[i], 'behavior:expression(EvPNG.fixPng(this))')

        }

    },
    applyVML: function(a) {
        a.runtimeStyle.cssText = '';
        this.vmlFill(a);
        this.vmlOffsets(a);
        this.vmlOpacity(a);
        if (a.isImg) {
            this.copyImageBorders(a)

        }

    },
    attachHandlers: function(b) {
        var c = this;
        var d = {
            resize: 'vmlOffsets',
            move: 'vmlOffsets'

        };
        if (b.nodeName == 'A') {
            var e = {
                mouseleave: 'handlePseudoHover',
                mouseenter: 'handlePseudoHover',
                focus: 'handlePseudoHover',
                blur: 'handlePseudoHover'

            };
            for (var a in e) {
                d[a] = e[a]

            }

        }
        for (var h in d) {
            b.attachEvent('on' + h, 
            function() {
                c[d[h]](b)

            })

        }
        b.attachEvent('onpropertychange', this.readPropertyChange)

    },
    giveLayout: function(a) {
        a.style.zoom = 1;
        if (a.currentStyle.position == 'static') {
            a.style.position = 'relative'

        }

    },
    copyImageBorders: function(a) {
        var b = {
            'borderStyle': true,
            'borderWidth': true,
            'borderColor': true

        };
        for (var s in b) {
            a.vml.color.shape.style[s] = a.currentStyle[s]

        }

    },
    vmlFill: function(a) {
        if (!a.currentStyle) {
            return

        } else {
            var b = a.currentStyle

        }
        for (var v in a.vml) {
            a.vml[v].shape.style.zIndex = b.zIndex

        }
        a.runtimeStyle.backgroundColor = '';
        a.runtimeStyle.backgroundImage = '';
        var c = (b.backgroundColor == 'transparent');
        var d = true;
        if (b.backgroundImage != 'none' || a.isImg) {
            if (!a.isImg) {
                a.vmlBg = b.backgroundImage;
                a.vmlBg = a.vmlBg.substr(5, a.vmlBg.lastIndexOf('")') - 5)

            } else {
                a.vmlBg = a.src

            }
            var e = this;
            if (!e.imgSize[a.vmlBg]) {
                var f = document.createElement('img');
                e.imgSize[a.vmlBg] = f;
                f.className = e.ns + '_sizeFinder';
                f.runtimeStyle.cssText = 'behavior:none; position:absolute; left:-10000px; top:-10000px; border:none;';
                f.attachEvent('onload', 
                function() {
                    this.width = this.offsetWidth;
                    this.height = this.offsetHeight;
                    e.vmlOffsets(a)

                });
                f.src = a.vmlBg;
                f.removeAttribute('width');
                f.removeAttribute('height');
                document.body.insertBefore(f, document.body.firstChild)

            }
            a.vml.image.fill.src = a.vmlBg;
            d = false

        }
        a.vml.image.fill.on = !d;
        a.vml.image.fill.color = 'none';
        a.vml.color.shape.style.backgroundColor = b.backgroundColor;
        a.runtimeStyle.backgroundImage = 'none';
        a.runtimeStyle.backgroundColor = 'transparent'

    },
    vmlOffsets: function(e) {
        var f = e.currentStyle;
        var g = {
            'W': e.clientWidth + 1,
            'H': e.clientHeight + 1,
            'w': this.imgSize[e.vmlBg].width,
            'h': this.imgSize[e.vmlBg].height,
            'L': e.offsetLeft,
            'T': e.offsetTop,
            'bLW': e.clientLeft,
            'bTW': e.clientTop

        };
        var i = (g.L + g.bLW == 1) ? 1: 0;
        var j = function(a, l, t, w, h, o) {
            a.coordsize = w + ',' + h;
            a.coordorigin = o + ',' + o;
            a.path = 'm0,0l' + w + ',0l' + w + ',' + h + 'l0,' + h + ' xe';
            a.style.width = w + 'px';
            a.style.height = h + 'px';
            a.style.left = l + 'px';
            a.style.top = t + 'px'

        };
        j(e.vml.color.shape, (g.L + (e.isImg ? 0: g.bLW)), (g.T + (e.isImg ? 0: g.bTW)), (g.W - 1), (g.H - 1), 0);
        j(e.vml.image.shape, (g.L + g.bLW), (g.T + g.bTW), (g.W), (g.H), 1);
        var k = {
            'X': 0,
            'Y': 0

        };
        var m = function(a, b) {
            var c = true;
            switch (b) {
                case 'left':
            case 'top':
                k[a] = 0;
                break;
                case 'center':
                k[a] = .5;
                break;
                case 'right':
            case 'bottom':
                k[a] = 1;
                break;
                default:
                if (b.search('%') != -1) {
                    k[a] = parseInt(b) * .01

                } else {
                    c = false

                }

            }
            var d = (a == 'X');
            k[a] = Math.ceil(c ? ((g[d ? 'W': 'H'] * k[a]) - (g[d ? 'w': 'h'] * k[a])) : parseInt(b));
            if (k[a] == 0) {
                k[a]++

            }

        };
        for (var b in k) {
            m(b, f['backgroundPosition' + b])

        }
        e.vml.image.fill.position = (k.X / g.W) + ',' + (k.Y / g.H);
        var n = f.backgroundRepeat;
        var p = {
            'T': 1,
            'R': g.W + i,
            'B': g.H,
            'L': 1 + i

        };
        var q = {
            'X': {
                'b1': 'L',
                'b2': 'R',
                'd': 'W'

            },
            'Y': {
                'b1': 'T',
                'b2': 'B',
                'd': 'H'

            }

        };
        if (n != 'repeat') {
            var c = {
                'T': (k.Y),
                'R': (k.X + g.w),
                'B': (k.Y + g.h),
                'L': (k.X)

            };
            if (n.search('repeat-') != -1) {
                var v = n.split('repeat-')[1].toUpperCase();
                c[q[v].b1] = 1;
                c[q[v].b2] = g[q[v].d]

            }
            if (c.B > g.H) {
                c.B = g.H

            }
            e.vml.image.shape.style.clip = 'rect(' + c.T + 'px ' + (c.R + i) + 'px ' + c.B + 'px ' + (c.L + i) + 'px)'

        } else {
            e.vml.image.shape.style.clip = 'rect(' + p.T + 'px ' + p.R + 'px ' + p.B + 'px ' + p.L + 'px)'

        }

    },
    fixPng: function(a) {
        a.style.behavior = 'none';
        if (a.nodeName == 'BODY' || a.nodeName == 'TD' || a.nodeName == 'TR') {
            return

        }
        a.isImg = false;
        if (a.nodeName == 'IMG') {
            if (a.src.toLowerCase().search(/\.png$/) != -1) {
                a.isImg = true;
                a.style.visibility = 'hidden'

            } else {
                return

            }

        } else if (a.currentStyle.backgroundImage.toLowerCase().search('.png') == -1) {
            return

        }
        var b = EvPNG;
        a.vml = {
            color: {},
            image: {}

        };
        var c = {
            shape: {},
            fill: {}

        };
        for (var r in a.vml) {
            for (var e in c) {
                var d = b.ns + ':' + e;
                a.vml[r][e] = document.createElement(d)

            }
            a.vml[r].shape.stroked = false;
            a.vml[r].shape.appendChild(a.vml[r].fill);
            a.parentNode.insertBefore(a.vml[r].shape, a)

        }
        a.vml.image.shape.fillcolor = 'none';
        a.vml.image.fill.type = 'tile';
        a.vml.color.fill.on = false;
        b.attachHandlers(a);
        b.giveLayout(a);
        b.giveLayout(a.offsetParent);
        b.applyVML(a)

    }

};
try {
    document.execCommand("BackgroundImageCache", false, true)

} catch(r) {}
EvPNG.createVmlNameSpace();
EvPNG.createVmlStyleSheet();