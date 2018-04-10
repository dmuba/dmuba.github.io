var do_list = function(id, file){
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            var myObj = JSON.parse(this.responseText);
            var html = '';
            for(var i=0;i < myObj.biblio.length; i++){
                 link =  myObj.biblio[i].link?' [ <a href="' + myObj.biblio[i].link+ '" target="_blank" > ' + myObj.biblio[i].caption + ' </a> ] </li>':'';
                 html = html + '<li>'+ myObj.biblio[i].ref + link;
            }
            document.getElementById(id).innerHTML = html
        }
    };
    xmlhttp.open("GET", file, true);
    xmlhttp.send();
 }

do_list("biblio","js/biblio.json");
do_list("clases","js/teoricas.json");
do_list("practicos","js/practicos.json");
