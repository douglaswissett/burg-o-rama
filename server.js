'use strict'
var express        = require('express');
var logger         = require('morgan');
var path           = require('path');
var bodyParser     = require('body-parser');
var methodOverride = require('method-override');
var db             = require('./db/pg');
var burgerRoutes   = require( path.join(__dirname, '/routes/burgers')); // this references burger routes
var app            = express();

// log
app.use( logger('dev') );
app.use( bodyParser.urlencoded({ extended: false })); 
app.use( bodyParser.json()); 
app.use(methodOverride('_method'));

/*Views*/
app.set('view engine', 'ejs');

app.use( express.static( path.join( __dirname, 'public' )));


// home route
app.get('/', (req,res)=>res.render('pages/home', {homeTitle: 'Welcome to Burg-O-Rama'}))


// BURGERS ROUTES FILE
app.use( '/burgers', burgerRoutes);














var port = process.env.PORT || 3000;
app.listen(port,()=> 
  console.log('Server Up! Ready to serve piping hot burgers on port', port,'//', new Date())
)