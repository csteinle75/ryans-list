var express = require('express');
var router = express.Router();
const conn = require('../lib/conn')
var path = require('path')
var multer = require('multer')

var upload = multer({
	dest: path.join(__dirname, '../public/uploads'),
})

/* GET home page. */
router.get('/', function(req, res, next) {
	const sql = `
	SELECT
		*
	FROM
		categories
	`
	let data = {
  			title: 'Ryan\'s List'
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
  		res.render('home', data)
  	})
});


//NOT YET DONE, FINISH NEXT
router.get('/category/:category', (req, res, next) =>{
	// const sql = `
	// 	SELECT
	// 		l.*,
	// 		c.*
	// 	FROM
	// 		listings l
	// 	LEFT JOIN categories c
	// 		ON l.category_id = c.id
	// 	WHERE c.slug LIKE '${req.params.category}' 
	// `

	// const sql = `
	// 	SELECT
	// 		*
	// 	FROM 
	// 		listings
	// `

	// Kevin J sql:
	// c.title,
	// c.slug,
	// l.description,
	// l.content



	let data = {
		title: req.params.category, 
		category: req.params.category,
	}
	
	// conn.query(sql, (err, results, fields) => {
	// 		console.log(results)
	// })
	res.render('category', data)
})

router.get('/view-listing/:listingid', (req, res, next) =>{
	const sql = `
	SELECT
		l.*,
		i.*,
		c.title, c.slug
	FROM 
		listings l
	LEFT JOIN images i
		ON l.id = i.listing_id
	LEFT JOIN categories c
		ON l.category_id = c.id
	WHERE
		l.id LIKE '${req.params.listingid}'

	`

	let data = {}

	conn.query(sql, (err, results, fields) =>{
		console.log(results)
		data.title = results[0].title
		data.id = results[0].listing_id
		data.category = results[0].title
		data.catid = results[0].category_id
		data.description = results[0].description
		data.image = results[0].image_path
		data.slug = results[0].slug

		console.log('data:', data)
		res.render('view-listing', data)
	})
})

router.get('/add-listing', (req, res, next) =>{

	const sql = `
	SELECT
		*
	FROM
		categories
	`
	let data = {
  			title: 'add listing'
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
  		res.render('add-listing', data)
  	})
})


router.post('/submit-listing', upload.single('listingImg'), (req, res, next) =>{
	console.log('request:', req.body)
	console.log('file', req.file)
	const title = req.body.title
	const description = req.body.description
	const category = req.body.category
	const listingImg = req.body.listingImg


	const sql  = `
	INSERT INTO
		listings (title, description, category_id)
		VALUES (?, ?, ?)
	`

	conn.query(sql, [title, description, category], (err, results, fields) =>{
		let listing_id = results.insertId
		const image_path = '/uploads/' + req.file.filename
		const imgSql = `
		INSERT INTO
			images (listing_id, image_path)
			VALUES(?,?)
		`
		conn.query(imgSql, [listing_id, image_path], (error, queryres, queryfields) =>{
			data = {
				title: 'test title'
			}
			res.redirect('/add-listing')
		})
	})
})



module.exports = router;
