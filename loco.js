
var loco = {

    /** input a table element, output a array. **/
    parseTable: function (table) {

        function parseTableRow(tr) {
            var i, l, tableRowArray=[];
            for(i=0,l=tr.children.length; i<l; i++)
                tableRowArray.push(tr.children[i].textContent.trim());
            return tableRowArray;
        }


        var tableArray = [];

        (function findTableRow(tableElement,tableArray) {
            var i,l,tableChild;
            for(i=0, l=tableElement.children.length; i<l; i++) {
                tableChild = tableElement.children[i];

                if(tableChild.nodeName.toLowerCase() == 'tr')
                    tableArray.push( parseTableRow(tableChild) );
                else
                    findTableRow(tableChild,tableArray);
            }
        })(table,tableArray);

        return tableArray;
    },


    /** input a text or element, output a element. **/
    autolink: function (t,tagName){

        function cu(u){
        // create url element and return. 
    
            var t = 'url', e;
            // t = type of url,
            // e = html element.
    
            if( /\.(jpe?g|gif|png)\?.*$/.test(u) ) t = 'img';
        
            switch(t){
            case 'url':
                e = document.createElement('a');
                e.href = u;
                e.textContent = u;
                break;
        
            case 'img':
                e = document.createElement('img');
                e.src = u;
                e.title = u;
                break;
            }
            return e;
        }


        if(typeof(t) != 'string') t = t.textContent;

        var nt = document.createElement(tagName || 'div');
        // nt: new text. 

        var u = new RegExp('https?://[^<>" ]+','gi');
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
