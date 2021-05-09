const EntitySchema = require("typeorm").EntitySchema;
const models = require('./models');

const CategorySchema = new EntitySchema({
    name: "Category",
    target: models.Category,
    columns: {
        id: {
            primary: true,
            type: "int",
            generated: true,
        },
        logo: {
            type: "text",
        },
        color: {
            type: "varchar",
        },
        order: {
            type: "int",
        },
        visible: {
            type: "boolean",
        }
    },
    relations: {
        translations: {
            target: "CategoryTranslation",
            type: "one-to-many",
            inverseSide: 'category',
            eager: true,
        },
        companies: {
            target: "Company",
            type: "one-to-many",
            inverseSide: 'category',
        }
    }
});


const CategoryTranslationSchema = new EntitySchema({
    name: "CategoryTranslation",
    target: models.CategoryTranslation,
    columns: {
        id: {
            primary: true,
            type: "int",
            generated: true,
        },
        title: {
            type: "varchar",
        },
        photo: {
            type: "text",
        },
        lang: {
            type: "varchar",
        },
    },
    relations: {
        category: {
            target: "Category",
            type: "many-to-one",
            nullable: false,
            joinColumn: true,
        }
    }
});




const CompanySchema = new EntitySchema({
    name: "Company",
    target: models.Company,
    columns: {
        id: {
            primary: true,
            type: "int",
            generated: true,
        },
        logo: {
            type: "text",
        },
        color: {
            type: "varchar",
        },
        phone: {
            type: 'varchar',
        },
        open_minute: {
            type: 'int'
        },
        close_minute: {
            type: 'int'
        },
        location_lat: {
            type: 'double',
        },
        location_lng: {
            type: 'double',
        },
        featured: {
            type: "boolean",
        },
        visible: {
            type: "boolean",
        },
    },
    relations: {
        translations: {
            target: "CompanyTranslation",
            type: "one-to-many",
            inverseSide: 'company',
            eager: true,
        },
        category: {
            target: "Category",
            type: "many-to-one",
            nullable: false,
            joinColumn: true,
        },
        products: {
            target: "Product",
            type: "one-to-many",
            inverseSide: 'company',
        },

        users: {
            target: "UserCompany",
            type: "one-to-many",
            inverseSide: 'company',
        },
    }
});

const CompanyTranslationSchema = new EntitySchema({
    name: "CompanyTranslation",
    target: models.CompanyTranslation,
    columns: {
        id: {
            primary: true,
            type: "int",
            generated: true,
        },
        title: {
            type: "varchar",
            nullable: false,
        },
        desc: {
            type: "text",
        },
        photo: {
            type: "text",
        },
        lang: {
            type: "varchar",
        },
    },
    relations: {
        company: {
            target: "Company",
            type: "many-to-one",
            nullable: false,
            joinColumn: true,
        }
    }
});




const ProductSchema = new EntitySchema({
    name: "Product",
    target: models.Product,
    columns: {
        id: {
            primary: true,
            type: "int",
            generated: true,
        },
        photo: {
            type: "text",
        },
        price: {
            type: "double",
            nullable: false,
        },
        discount_price: {
            type: 'double',
        },
        discount_start_data: {
            type: 'int'
        },
        discount_end_data: {
            type: 'int'
        },

        visible: {
            type: "boolean",
            nullable: false,
            default: true,
        },
        featured: {
            type: "boolean",
            nullable: false,
            default: false,
        }
    },
    relations: {
        translations: {
            target: "ProductTranslation",
            type: "one-to-many",
            inverseSide: 'product',
            eager: true,
        },
        company: {
            target: "Company",
            type: "many-to-one",
            nullable: false,
            joinColumn: true,
        },
        carts: {
            target: "Cart",
            type: "one-to-many",
            inverseSide: 'product',
        },
    }
});

const ProductTranslationSchema = new EntitySchema({
    name: "ProductTranslation",
    target: models.ProductTranslation,
    columns: {
        id: {
            primary: true,
            type: "int",
            generated: true,
        },
        title: {
            type: "varchar",
            nullable: false,
        },
        desc: {
            type: "text",
        },
        lang: {
            type: "varchar",
        },
    },
    relations: {
        product: {
            target: "Product",
            type: "many-to-one",
            nullable: false,
            joinColumn: true,
        }
    }
});







const UserSchema = new EntitySchema({
    name: "User",
    target: models.User,
    columns: {
        id: {
            type: "varchar",
            primary: true,
        },
        first_name: {
            type: 'varchar'
        },
        last_name: {
            type: 'varchar'
        },
        email: {
            type: 'varchar',
        },
        phone: {
            type: 'varchar'
        },
        gender: {
            type: 'boolean'
        },
        photo: {
            type: 'varchar'
        },
        location_lng: {
            type: 'double'
        },
        location_lat: {
            type: 'double'
        },
        prefered_city: {
            type: 'varchar',
        },
        prefered_lang: {
            type: 'varchar',
        },
        is_locked: {
            type: 'boolean',
            nullable: false,
            defaultValue: false,
        },
        phone_verifed: {
            type: 'boolean',
            nullable: false,
            defaultValue: false,
        },
        push_notification_token: {
            type: 'text',
        },
    },
    relations: {
        carts: {
            target: "Cart",
            type: "one-to-many",
            inverseSide: 'user',
        },
        companies: {
            target: "UserCompany",
            type: "one-to-many",
            inverseSide: 'user',
        },
    }
});

const CartSchema = new EntitySchema({
    name: "Cart",
    target: models.Cart,
    columns: {
        id: {
            primary: true,
            type: "int",
            generated: true,
        },
        quantity: {
            type: 'int',
        },
    },
    relations: {
        product: {
            target: "Product",
            type: "many-to-one",
            nullable: false,
            joinColumn: true,
        },
        user: {
            target: "User",
            type: "many-to-one",
            nullable: false,
            joinColumn: true,
        }
    }
});




const UserCompanySchema = new EntitySchema({
    name: "UserCompany",
    target: models.UserCompany,
    columns: {
        id: {
            primary: true,
            type: "int",
            generated: true,
        },
        role: {
            type: 'varchar',
        },
    },
    relations: {
        comapny: {
            target: "Company",
            type: "many-to-one",
            nullable: false,
            joinColumn: true,
        },
        user: {
            target: "User",
            type: "many-to-one",
            nullable: false,
            joinColumn: true,
        }
    }
});




module.exports = {
    CategorySchema,
    CategoryTranslationSchema,
    CompanySchema,
    CompanyTranslationSchema,

    ProductSchema,
    ProductTranslationSchema,

    UserSchema,
    CartSchema,

    UserCompanySchema,
};