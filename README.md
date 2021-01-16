# ImRepo

This project was inspired by Shopify's 2021 Internship challenge for Backend Developer and Site Reliability Engineering Intern.

## About ImRepo

ImRepo is an ecommerce store, where users can browser Images (i.e. products) and buy their rights to use them.

This application was made using `Ruby on Rails`.

### Features Implemented:

* Unauthenticated Users
  * ImRepo allows users that have not logged in so far to view the Images and Categories page. Until they don't login they won't be able to purchase an image.
  *  Accessible routes or actions for all authenticated and unauthenicated users:
		* `/images`
			* index / search images
		* `/categories/:id`
			* index categories
			* show a category (this shows all images in a category)

* Authenticated Users/Customers
	* Are now able to modify their account balance.
	* Can view their order history.
	* User accounts were implemented using the `devise gem`
	* User can sign up via this route: `/users/sign_up` and sign in via `/users/sign_in`
	* Accessible routes or actions:
		* `/images`
			* index / search images
			* Buy images
		* `/users/:id/account`
			* show their account (this view only allows them to update their balance for now)
		* `/users/:id/orders`
			* index of all their orders

* Admin
	* Admins were implemented using the `devise gem` as well
	* They were slightly tweaked such that, the admin cannot sign_up and can only be created via `rails console`
	* Accessible routes or actions:
		* `/admin/products`
			* index all products
			* search products
			* create new product
			* update product
				* Does not allow updating the image (since that is the product).
			* delete product
		* `/admin/categories`
			* index all categories
			* search categories
			* create new category
			* update category
			* delete category
		* `/admin/orders`
			* index all orders

### Models

* User
	* created using `devise`
	* Relationships:
		*  one-to-one relationship with `Account`
		* one-to-many relationship with `Order`

* Admin
	* created using `devise` and kept to `default`

* Product
	* Images are the product of this store. I have chosen to have them named products in the backend because this gives me the ability to maybe introduce different types of products if I choose to do so.
	* Relationships:
		* Has an attachment <- this is the image that is stored via `active-storage` Ideally, I wanted to store the images on `AWS S3`, but for the sake of time I used active-storage to store the images.
		* many-to-many relationship with `Category`
			* This allows for products to be apart of many categories and a category can have many images.

* Category
	* Category is utilized to organize images/products on the store. This allows us to create unique categories for products such as cartoon, cars, sale, etc.
	* Relationships:
		* many-to-many relationship with `Product`
		* one-to-many relationship with `Order`

* Product Category
	* This model was created to store the many to many relationship between a product and category in the db. This also, allows for dependent deletion of the relationship and associations.

* Account
	* Account stores a user's balance. (In the future will add more attributes like profile information)
	* Relationships:
		* one-to-one relationship between Account and `User`
		* one-to-many relationship between Account and `Order`
			* An account can have many orders, but an order can only have one account associated to it

* Order
	* Allows association of product, user, and account.
	* The order, also contains a cost attribute, to show how much the customer paid for the product at the time of purchase.
	* Relationships:
		* has one `account`, `user` and `product`