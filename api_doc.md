
# API Documentation

## CATEGORIES
- **GET** `/categories?lang=en`
- **POST** `/categories/`

	{
	    title: string,
            photo: string, //url
            lang: string, // en ar fr ...
            logo: string, //url
            visible: bool, 
            order: int, 
        }
- **PUT** `/categories/[id]  `
        
        { 
            logo: string, //url
            visible: bool, 
            order: int, 
        }

- **DELETE** `/categories/[id]`

- **GET** `/categories/[id]/translations`
- **POST** `/categories/[id]/translations`
        
        { title, photo, lang }
- **PUT** `/categories/translations/[id]`
        
        { title, photo, lang }
- **DELETE** `/categories/translations/[id]`



## COMPANIES

- **GET** `/categories/[id]/companies?lang=en`
- **GET** `/categories/[id]/companies/featured?lang=en`
- **GET** `/companies/[id]?lang=en`
- **POST** `/companies/`

        {
            title,
            desc,
            photo,
            lang,

            logo,
            phone,
            open_minute: int,  // the minute of opening for the store,
                            // ex:if it open 9:30PM --> value = 9.5 * 60
            close_minute: int, // same as before
            featured: bool,
            visiable: bool,
            categoryId: int,
            location_lat: double,
            location_lng: double,
            visible: bool,
        }
- **PUT** `/companies/[id]`

        {
            logo,
            phone,
            open_minute: int,  // the minute of opening for the store,
                            // ex:if it open 9:30PM --> value = 9.5 * 60
            close_minute: int, // same as before
            featured: bool,
            visiable: bool,
            categoryId: int,
            location_lat: double,
            location_lng: double,
        }


- **GET** `/companies/[id]/translations`
- **POST** `/companies/[id]/translations`
        
        { title, photo, desc, lang }
- **PUT** `/companies/translations/[id]`
        
        { title, photo, desc, lang }
- **DELETE** `/companies/translations/[id]`


## PRODUCTS

- **GET** `/companies/[id]/products?lang=en`

- **GET** `/products/featured?lang=en`
- **POST** `/products/`
    
        {
            title,
            desc,
            lang,

            featured: bool,
            visible: bool,
            companyId,
            photo: string, // url
            price: double,
            discount_end_data: int, // utc timestamp
            discount_price: double,
            discount_start_data // utc timestamp
        }
- **PUT** `/products/[id]`
       
       {
            featured: bool,
            visible: bool,
            companyId,
            photo: string, // url
            price: double,
            discount_end_data: int, // utc timestamp
            discount_price: double,
            discount_start_data // utc timestamp
        }

- **GET** `/products/[id]/translations`
- **POST** `/products/[id]/translations`
            
        { title, desc, lang }
- **PUT** `/products/translations/[id]`
        
        { title, desc, lang }
- **DELETE** `/products/translations/[id]`


## USERS

- **GET** `/users/[id]`
- **POST** `/users/[id]`

        {
            first_name,
            last_name,
            photo,
            email,
            gender: bool,   
            is_locked,
            phone,
            phone_verifed: bool,     
        }
- **PUT** `/users/[id]`
    
        {
            first_name,
            last_name,
            photo,
            email,
            gender: bool,   
            is_locked,
            phone,
            phone_verifed: bool,     
        }

- **POST** `/users/[id]/lock`
- **POST** `/users/[id]/unlock`

- **POST** `/users/[id]/city/[cityName]`
- **POST** `/users/[id]/lang/[langCode]`
- **POST** `/users/[id]/location/[lat]/[lng]`

- **GET** `/users/[id]/cart`
- **POST** `/users/[id]/cart/[productId]/[quantity]`
- **DELETE** `/users/cart/[cart]`
- **PUT** `/users/cart/[cart]/[quantity]`

- **POST** `/users/[id]/roles/[companyId]/[roleName]`
- **DELETE** `/roles/[id]`

## Card
- **GET** /getallcart/[moblie]/[lang]
- **GET** /check_card/[userMobile]
- **GET** /charge_card/[CardNumber]/[userMobile]

## Cart
- **POST**   /addtocart/[userMobile]
		{
    			"quantity":"10", "productId":"1"
		}
- **DELETE** /removfromcart/[userMobile]/[proudutID]
- **DELETE** /removallcart[userMobile]

## Products
- **GET** /products/1,2,3,4,5,8,9/en

## Companies
- **GET** /companies/1,2,3,4,5,8,9/en

## Search
- **GET** /search/الساعة/ar




## Add Product User Comapny
- **POST** `/api/editorders/[mobile]` 

	{ 
	    id, // Int if don't enter id property then request is insert if insert id check id and update product
	    lang, //en
	    title, // title en
	    photo, // url string	
	    price, // double default 0
	    discount_price, // double default 0
	    discount_start_data, // default current timestamp
	    discount_end_data, // default 0
	    visible // default 0
	}