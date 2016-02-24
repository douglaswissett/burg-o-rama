'use strict'
var express = require('express');
var db      = require('../db/pg');
var burgers = express.Router();






var dumpMethod = (req,res)=>res.send( req.method + " dump'd")

// SHOW BURGERS
burgers.route('/')
.get( db.showBurgers, (req,res) => {
  
  res.render('pages/burger_list', {
    burgerData: res.rows
  });
})

// CREATE new burger
.post( db.addOrder,db.addCheese,db.addTopping, (req, res) => {
  res.redirect('/burgers/');
});




// SHOW NEW BURGER FORM
burgers.get('/new', db.showBurgers, (req,res)=>
  res.render('pages/burger_edit', { 
    burgerForm:{ 
      title:'Create your Dream Burger',
      burgerURL:'/burgers/', 
      submitMethod:'post'
    },
    orderID: res.rows.length + 1
  })
)





// SINGLE BURGER
burgers.route('/:id')
.get( db.showAllBurgers, (req, res) => {
  var bID = req.params.id;

  if(!((bID -1) in res.rows)) {
    res.sendStatus(404);
    return;
  }
  console.log(res.rows[bID-1]);
  res.render('pages/burger_one', { data: res.rows[bID-1] });
})
.put( (req, res) => {
  var bID = req.params.id;
  
  if(!((bID-1) in burgerData)) {
    res.sendStatus(404);
    return;
  }

  res.redirect(303,'/burgers/');
})
.delete( (req, res) => {
  var bID = req.params.id;
  // if(!(bID in burgerData)) {
  //   res.redirect(303,'/burgers/');
  //   return;
  // }

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