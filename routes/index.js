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


//does not display listings when main categories selected
router.get('/category/:category/:view?', (req, res, next) =>{
	
	const queryid = `
	SELECT id, title as catname
	FROM categories
	WHERE slug like ?
	`

	conn.query(queryid, [req.params.category], (err, results, fields) =>{
		// console.log('category id:',results[0])
		const catId = results[0].id
		const catName = results[0].catname

		const querylistings = `
		SELECT l.*, i.image_path
		FROM listings l
		LEFT JOIN categories c
			ON l.category_id = c.id
		LEFT JOIN images i
			ON l.id = i.listing_id
		WHERE l.category_id = ? OR c.parent_id = ?
		ORDER BY 
			l.id DESC
		`

		conn.query(querylistings, [catId, catId], (err2, results2, fields2) =>{

			data = {
				title: catName,
				listings: results2.map(result => {return{...result}}),
				slug: req.params.category,
				view: req.params.view
			}

			res.render('category', data)
		})
	})

})



router.get('/view-listing/:listingid', (req, res, next) =>{
	const sql = `
	SELECT
		l.*,
		i.*,
		c.title as catname, c.slug
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
		data.title = results[0].title
		data.id = results[0].listing_id
		data.category = results[0].catname
		data.catid = results[0].category_id
		data.description = results[0].description
		data.image = results[0].image_path
		data.slug = results[0].slug
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
	// console.log('request:', req.body)
	console.log('file', req.file)

	const title = req.body.title
	const description = req.body.description
	const category = req.body.category
	const listingImg = req.body.listingImg
	const zipcode = req.body.zipcode ? req.body.zipcode : 00000
	let price
	if (Number.isNaN(parseFloat(req.body.price))){
		price = 0
	} else {price = parseFloat(req.body.price)}

	let imgpath
	if (req.file !== undefined){
		imgpath = '/uploads/' + req.file.filename
	} else {imgpath = 'http://placehold.it/300/300'}

	const sql  = `
	INSERT INTO
		listings (title, description, category_id, price, zipcode)
		VALUES (?, ?, ?, ?, ?)
	`

	conn.query(sql, [title, description, category, price, zipcode], (err, results, fields) =>{
		console.log(results)
		let listing_id = results.insertId
		const imgSql = `
		INSERT INTO
			images (listing_id, image_path)
			VALUES(?,?)
		`
		console.log('imgpath:', imgpath)
		conn.query(imgSql, [listing_id, imgpath], (error, queryres, queryfields) =>{
			data = {
				title: 'test title'
			}
			res.redirect('/add-listing')
		})
	})
})



module.exports = router;
