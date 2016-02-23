'use strict'
var express = require('express');
var burgers = express.Router();


var burgerData = [];

var dumpMethod = (req,res)=>res.send( req.method + " burgers!" )



// SHOW BURGERS
burgers.route('/')
.get( (req,res) => {
  
  res.render('pages/burger_list', {
    data: burgerData
  });
})

.post( (req, res) => {
  burgerData.push(req.body);

  var newID = burgerData.length-1;
  res.redirect('/burgers/' + newID);
});




// SHOW NEW BURGER FORM
burgers.get('/new', (req,res)=>
  res.render('pages/burger_edit', { 
    burgerForm:{ 
      title:'Create your Dream Burger',
      burgerURL:'/burgers/', 
      submitMethod:'post'
    }
  })
)





// SINGLE BURGER
burgers.route('/:id')
.get( (req, res) => {
  var bID = req.params.id;

  if(!(bID in burgerData)) {
    res.sendStatus(404);
    return;
  }

  res.render('pages/burger_one', { data: burgerData[bID] });
})
.put( (req, res) => {
  var bID = req.params.id;
  
  if(!(bID in burgerData)) {
    res.sendStatus(404);
    return;
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
});



// SHOW EDIT BURGER FORM
burgers.get('/:id/edit', (req, res) => {
  res.render('pages/burger_edit', { 
    burgerForm:{ 
      title:'Edit your Dream Burger',
      burgerURL:'/burgers/'+ req.params.id+'?_method=PUT', 
      submitMethod:'post'
    }
  })
});










module.exports = burgers;