'use strict'
var express        = require('express');
var logger         = require('morgan');
var path           = require('path');
var bodyParser     = require('body-parser');
var methodOverride = require('method-override');
var app            = express();
var burgerRoutes   = require( path.join(__dirname, '/routes/burgers')); // this references burger routes

// log
app.use( logger('dev') );
app.use( bodyParser.urlencoded({ extended: false })); 
app.use( bodyParser.json()); 
app.use(methodOverride('_method'));

/*Views*/
app.set('view engine', 'ejs');

var dumpMethod = (req,res)=>res.send( req.method + " burgers!" );
// ROUTES

// HOMEPAGE
app.get('/', dumpMethod);


// BURGERS ROUTES FILE
app.use( '/burgers', burgerRoutes);


















var port = process.env.PORT || 3000;
app.listen(port,()=> 
  console.log('Server Up! Ready to serve piping hot burgers on port', port,'//', new Date())
)