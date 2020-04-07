var _sdbag = _sdbag || [];
 
_sdbag.push(['partnerId', 404]); //replace it with your partner id
_sdbag.push(['shopId', 9]); //replace it with your shop id
_sdbag.push(['country', 'de']); //replace it with your customer's country code
 
_sdbag.push(['orderId', '32432432432']); // replace it with the order id
 
 // customer data
_sdbag.push(['customer', {
    firstname: "John",
    lastname: "Smith",
    email: "dadsadsda@example.com",
    phone: "+49 (30) 00000000",
    street: "Berliner str.",
    street_number: 178,
    zip: 10115,
    city: "Berlin",
    country: "de"
}]);
 
// COMMENT OUT IF YOU WANT TO WORK ON SANDBOX (PARTNER ID AND SHOP ID VALUES WILL BE DIFFERENT)
//_sdbag.push(['sandbox', true]);
 
// COMMENT OUT IF YOU WANT TO SEE DEBUG OUTPUT IN BROWSER'S JS CONSOLE. DO NOT ACTIVATE THIS IN PRODUCTION USE
//_sdbag.push(['debug', true]);

// This indicates which page you are initializing the plugin. Use "success" for success page.
_sdbag.push(['page', 'success']);

_sdbag.push(['init', 'success']);
 
(function() {
    var ss = document.createElement('script'); ss.type = 'text/javascript'; ss.async = true;
    ss.src = ('https:' == document.location.protocol ? 'https://' : 'http://')  + 'jsapi.simplesurance.de/sisu-checkout-2.x.min.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ss, s);
})();
