function openTab(evt, to) {
    var i, tabcontent, tablines;
    tabcontent = document.getElementsByClassName("tabs");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
                
    }
    tablines = document.getElementsByClassName("tabsB");
    for (i = 0; i < tabcontent.length; i++) {
       tablines[i].style.background="#D8D446";
    }
    
    document.getElementById(to).style.display = "block";
    document.getElementById(to+"0").style.background="#F48A4E";
}