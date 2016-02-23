'use strict'
var express = require('express');
var burgers = express.Router();


var burgerData = [];

var dumpMethod = (req,res)=>res.send( req.method + " burgers!" )


// SHOW BURGERS
burgers.route('/')
.get( (req,res) => {
  console.log('burger route hit!');
  res.send(burgerData);
})

.post( (req, res) => {
  burgerData.push(req.body)

  var newID = burgerData.length-1;
  res.redirect('/burgers/' + newID);
})

// SINGLE BURGER
burgers.route('/:id')
.get( (req, res) => {
  var bID = req.params.id;

  if(!(bID in burgerData)) {
    res.sendStatus(404);
    return;
  }

  res.send(burgerData[bID]);
})
.put( (req, res) => {
  var bID = req.params.id;
  
  if(!(bID in burgerData)) {
    res.sendStatus(404);
    return
  }

  burgerData[bID] = req.body;
  res.redirect(303,'/burgers/' + bID);
})
.delete( (req, res) => {
  var bID = req.params.id;
  if(!(bID in burgerData)) {
    res.redirect(303,'/burgers/');
    return;
  }

  burgerData.splice(bID, 1);
  res.redirect(303,'/burgers/');
})

// SHOW NEW BURGER FORM
burgers.get('/new', dumpMethod)

// SHOW EDIT BURGER FORM
burgers.get('/:id/edit', dumpMethod)








module.exports = burgers;