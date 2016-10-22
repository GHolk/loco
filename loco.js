
var loco = {

    parseQueryString: function (queryString) {

        if (queryString.charAt(0) == '?')
            queryString = queryString.substr(1);

        var keyValueArray = queryString.split(/&|=/),
            keyValues = {};

        for (var i=0; i<keyValueArray.length; i+=2)
            keyValues[  decodeURIComponent( keyValueArray[i] )  ]
                = decodeURIComponent( keyValueArray[i+1] );

        return keyValues;
    },

    /** input a table element, output a array. **/
    parseTable: function (table) {

        var rows = Array.prototype.slice.call(table.rows,0),
            tableArray = [], 
            cellElements, 
            rowArray, i, j;

        for(i=0; i<rows.length; i++) {

            cellElements = Array.prototype.slice.call(rows[i].cells,0),
            rowArray = [];

            for(j=0; j<cellElements.length; j++)
                rowArray.push(cellElements[j].textContent.trim());

            tableArray.push(rowArray);
        }

        return tableArray;
    },

    /** input a text or element, output a element. **/
    autoLink: function (t,tagName) {

        function cu(u){
        // create url element and return. 
    
            var t = 'url', e, img;
            // t = type of url,
            // e = html element.
    
            if( /\.(jpe?g|gif|png)(\?.*)?$/i.test(u) ) t = 'img';

            e = document.createElement('a');
            e.href = u;

            switch (t) {
            case 'url':
                e.textContent = u;
                break;

            case 'img':
                img = document.createElement('img');
                img.src = u;
                e.appendChild(img);
                break;
            }
            return e;
        }


        if(typeof(t) != 'string') t = t.textContent;

        var nt = document.createElement(tagName || 'div');
        // nt: new text. 

        var u = /https?:\/\/[^<>" \n]+/gi;
        // regexp within `/`, use '' dont need escape `/`. 
        var at = t.split(u); // at: anchor text. 
        var au = t.match(u); // au: anchor url.
        if(au === null) {
            nt.textContent = t;
            return nt;
        }

        for (var i=0, l=at.length-1; i<l; i++){
            nt.appendChild( document.createTextNode(at[i]) );
            nt.appendChild( cu(au[i]) );
        }
        nt.appendChild( document.createTextNode(at[i]) );

        return nt;
    }
};

