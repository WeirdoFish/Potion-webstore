function categChanged() {
    var value = document.getElementsByTagName('select')[0].value;
    var pValue = document.getElementsByTagName('select')[1].value;
    
    var date = new Date(new Date().getTime() + 15 * 1000);
    document.cookie = "categ=" + value + ";path=/; expires=" + date.toUTCString();
    document.cookie = "price=" + pValue + ";path=/; expires=" + date.toUTCString();
    window.location='?categ=' + value +'&price=' + pValue;
}

