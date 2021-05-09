require('dotenv').config();
const typeorm = require("typeorm");
const getRepository = require("typeorm").getRepository;
const schemas = require('./schema');
const models = require('./models');

module.exports = {
    categoryRepo: () => getRepository(models.Category),
    categoryTranRepo: () => getRepository(models.CategoryTranslation),
    companyRepo: () => getRepository(models.Company),
    companyTranRepo: () => getRepository(models.CompanyTranslation),
    productRepo: () => getRepository(models.Product),
    productTranRepo: () => getRepository(models.ProductTranslation),
    userRepo: () => getRepository(models.User),
    cartRepo: () => getRepository(models.Cart),
    userCompanyRepo: () => getRepository(models.UserCompany),

    DbProvider: (callback) => typeorm.createConnection({
        type: process.env.DB_ENIG,
        host: process.env.DB_SRVR,
        port: process.env.DB_PORT,
        username: process.env.DB_USER,
        password: process.env.DB_PWSD,
        database: process.env.DB_NAME,
        // charset: 'UTF8_GENERAL_CI',
        // synchronize: true,
        entities: [
            schemas.CategorySchema,
            schemas.CategoryTranslationSchema,
            schemas.CompanySchema,
            schemas.CompanyTranslationSchema,
            schemas.ProductSchema,
            schemas.ProductTranslationSchema,
            schemas.UserSchema,
            schemas.CartSchema,
            schemas.UserCompanySchema,
        ]
    }).then(() => {
        console.log('db connected')
        callback();
    }).catch((error) => {
        console.log("Db connection error", error);
    })
};