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

	conn.connect()
  	conn.query(sql, (err, results, fields) => {
  		console.log(results)
  		let data = {
  			title: 'blah',
  			categories: results
  		}
  		res.render('home', data)
  	})
  	conn.end()
});

module.exports = router;
