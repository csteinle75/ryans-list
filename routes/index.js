var express = require('express');
var router = express.Router();
const conn = require('../lib/conn')
var multer = require('multer')

/* GET home page. */
router.get('/', function(req, res, next) {
	const sql = `
	SELECT
		*
	FROM
		categories
	`
	let data = {
  			title: 'blah'
  		}

  	conn.query(sql, (err, results, fields) => {
  		data.categories = results.filter(result => result.parent_id === null)
  		data.categories.map( cat => {
  			let subcat = results.filter( result => {
  				if (result.parent_id === cat.id){
  					return result
  				}
  			})
  			cat.subcategories = subcat
  		})
  		// console.log(data.categories)
  		res.json(data)
  		// res.render('home', data)
  	})
});

module.exports = router;
