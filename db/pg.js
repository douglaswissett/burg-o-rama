var pg = require('pg');
var conString = "postgres://douglaswalker:dww1234@localhost/burgoramadb";




function showBurgers(req, res, next) {
  pg.connect(conString, function(err, client, done) {
    if(err) {
      return console.error('error fetching client from pool', err);
    }
    client.query('SELECT * FROM orders', function(err, result) {
      done();

      if(err) {
        return console.error('error running query', err);
      }

      //console.log(result.rows);
      res.rows = result.rows;
      next();
    });
  });
}





function showAllBurgers(req, res, next) {
  pg.connect(conString, function(err, client, done) {
    if(err) {
      return console.error('error fetching client from pool', err);
    }

 
/* complex query FROM: Jason Semiera / Max Rayman */

    client.query(`select
  orderid,
  doneness,
  meat_type,
  bun_type,
  cheeses,
  array_agg(t.type) as toppings
from (

  select
    o.orderid,
    o.doneness,
    meat.type as meat_type,
    bread.type as bun_type,
    array_agg(c.type) as cheeses
  from orders o

  -- get the meats using meatid on both sides
  left join meat using (meatid)

  -- get the buns using bunid on both sides
  left join bread using (breadid)

  -- use an inner join here because we only care about OUR orders/cheeses
  inner join order_cheese oc using(orderid)

  -- left join here because we want to capture orders w/o cheese
  left join cheese c using (cheeseid)

  group by (o.orderid, o.doneness,  meat.type, bread.type)
  order by o.orderid

) as justCheese

-- use an inner join here because we only care about OUR orders/cheeses
inner join order_topping ot using(orderid)

-- left join here because we want to capture orders w/o topping
left join topping t using (toppingid)

group by orderid, doneness, meat_type, bun_type, cheeses
order by justCheese.orderid`,  

      function(err, result) {
      done();

      if(err) {
        return console.error('error running query', err);
      }


      res.rows = result.rows;
      //console.log(res.rows);
      next();
    });
  });  
}


function addOrder(req, res, next) {

  // console.log(req.body.orderid);

  pg.connect(conString, function(err, client, done) {

    if(err) {
      return console.error('error fetching client from pool', err);
    }
    client.query('INSERT INTO orders (meatid, breadid, doneness) VALUES ($1, $2, $3)',
     [req.body.meatid, req.body.breadid, req.body.temperature],
     function(err, result) {
      done();

      if(err) {
        return console.error('error running query', err);
      }
      next();
    });
  });
}


function buildStatement(rows, columns, table) {
  var params = [];
  var chunks = [];
  var i, j, row, valuesClause;
  for(i = 0; i < rows.length; i++) {
    row = rows[i];
    valuesClause = [];
    for(j = 0; j < row.length; j++){
      params.push(row[j]);
      valuesClause.push('$' + params.length);
    }
    chunks.push('(' + valuesClause.join(', ') + ')');
  }
  return {
    query: 'INSERT INTO ' + table + '( ' + columns.join(', ') + ' ) VALUES ' + chunks.join(', '),
    values: params
  };
}


function addCheese(req, res, next) {
  var data = [];
  
  // guarded if no cheese is selected
  if(!req.body.cheeseid) {
    res.redirect('/burgers/' + req.body.orderid);
    return;
  }

  if(!(typeof(req.body.cheeseid) === 'string')) {
    var data = [];
    req.body.cheeseid.forEach(function(id) {
      data.push([+(req.body.orderid), +(id)]);
    })
  } else {
    data.push([+(req.body.orderid), +(req.body.cheeseid)]);
  }


  var statement = buildStatement(data, ['orderid', 'cheeseid'], 'order_cheese');

  pg.connect(conString, function(err, client, done) {
    if(err) {
      return console.error('error fetching client from pool', err);
    }

    client.query( statement.query ,
     statement.values,
     function(err, result) {
      done();

      if(err) {
        return console.error('error running query', err);
      }
      next();
    });
  });
}

function addTopping(req, res, next) {
  var data = [];
  
  if(!req.body.toppingid) {
    res.redirect('/burgers/' + req.body.orderid);
    return;
  }

  if(!(typeof(req.body.toppingid) === 'string')) {
    var data = [];
    req.body.toppingid.forEach(function(id) {
      data.push([+(req.body.orderid), +(id)]);
    })
  } else {
    data.push([+(req.body.orderid), +(req.body.toppingid)]);
  }


  var statement = buildStatement(data, ['orderid', 'toppingid'], 'order_topping');

  pg.connect(conString, function(err, client, done) {

    if(err) {
      return console.error('error fetching client from pool', err);
    }


    client.query(statement.query,
     statement.values,
     function(err, result) {
      done();

      if(err) {
        return console.error('error running query', err);
      }
      next();
    });
  });
}


function editOrder(req, res, next) {

  var orderID = req.body.orderid;
  console.log(orderID, req.body.meatid, req.body.breadid, req.body.temperature)

  pg.connect(conString, function(err, client, done) {

    if(err) {
      return console.error('error fetching client from pool', err);
    }
    client.query('UPDATE orders as o SET meatid = $1, breadid = $2, doneness = $3 WHERE o.orderid = $4;',
    [ req.body.meatid, req.body.breadid, req.body.temperature, orderID ],
     function(err, result) {
      done();

      if(err) {
        return console.error('error running query', err);
      }
      next();
    });
  });
}

    

module.exports.showBurgers    = showBurgers;
module.exports.showAllBurgers = showAllBurgers;
module.exports.addOrder       = addOrder;
module.exports.addCheese      = addCheese;
module.exports.addTopping     = addTopping;
module.exports.editOrder      = editOrder;
