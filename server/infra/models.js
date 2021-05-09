
class Translatable {
    extract(translations, lang) {
        if (translations) {
            let t = translations.filter(x => x.lang == lang);
            if (t && t.length > 0) {
                t = t[0];
            }
            else if (!t || t.length === 0) {
                t = translations[0];
            }
            if (t) {
                const { id, ...withoutId } = t;
                return withoutId;
            }
        }
        return {};
    }

    flatTranslation(translations, lang) {
        const tran = this.extract(translations, lang);
        for (const key in tran) {
            if (Object.hasOwnProperty.call(tran, key) && key !== 'lang') {
                this[key] = tran[key];
            }
        }
        delete this.translations;
    }
}


class Category extends Translatable {
    static build({ id, logo, color, order, visible }) {
        return new Category(id, logo, color, order, visible);
    }
    constructor(id, logo, color, order, visible) {
        super();
        this.id = id;
        this.logo = logo;
        this.order = order;
        this.color = color;
        this.visible = visible;
    }
}

class CategoryTranslation {
    static build({ id, title, photo, lang }) {
        return new CategoryTranslation(id, title, photo, lang);
    }
    constructor(id, title, photo, lang) {
        this.id = id;
        this.title = title;
        this.photo = photo;
        this.lang = lang;
    }
}

class Company extends Translatable {
    static build({ id, logo, phone, location_lat, location_lng, open_minute, close_minute, featured, visible }) {
        return new CategoryTranslation(id, logo, phone, location_lat, location_lng, open_minute, close_minute, featured, visible);
    }
    constructor(id, logo, phone, location_lat, location_lng, open_minute, close_minute, featured, visible) {
        super();
        this.id = id;
        this.logo = logo;
        this.phone = phone;
        this.location_lat = location_lat;
        this.location_lng = location_lng;
        this.open_minute = open_minute;
        this.close_minute = close_minute;
        this.featured = featured;
        this.visible = visible;
    }
}

class CompanyTranslation {
    static build({ id, title, desc, photo, lang }) {
        return new CompanyTranslation(id, title, desc, photo, lang);
    }
    constructor(id, title, desc, photo, lang) {
        this.id = id;
        this.title = title;
        this.photo = photo;
        this.desc = desc;
        this.lang = lang;
    }
}

class Product extends Translatable {
    static build({ id, photo, price, visible, discount_price, discount_start_data, discount_end_data, featured }) {
        return new ProductTranslation(id, photo, price, visible, discount_price, discount_start_data, discount_end_data, featured);
    }
    constructor(id, photo, price, visible, discount_price, discount_start_data, discount_end_data, featured) {
        super();
        this.id = id;
        this.photo = photo;
        this.price = price;
        this.visible = visible;
        this.discount_price = discount_price;
        this.discount_start_data = discount_start_data;
        this.discount_end_data = discount_end_data;
        this.featured = featured;
    }
}

class ProductTranslation {
    static build({ id, title, desc, lang }) {
        return new ProductTranslation(id, title, desc, lang);
    }
    constructor(id, title, desc, lang) {
        this.id = id;
        this.title = title;
        this.desc = desc;
        this.lang = lang;
    }
}

class User {
    static build({ id, first_name, last_name, email, phone, gender, photo, location_lng, location_lat, prefered_city, prefered_lang, is_locked, phone_verifed, push_notification_token, }) {
        return new User(id, first_name, last_name, email, phone, gender, photo, location_lng, location_lat, prefered_city, prefered_lang, is_locked, phone_verifed, push_notification_token,);
    }
    constructor(id, first_name, last_name, email, phone, gender, photo, location_lng, location_lat, prefered_city, prefered_lang, is_locked, phone_verifed, push_notification_token,) {
        this.id = id;
        this.first_name = first_name;
        this.last_name = last_name;
        this.email = email;
        this.phone = phone;
        this.gender = gender;
        this.photo = photo;
        this.location_lng = location_lng;
        this.location_lat = location_lat;
        this.prefered_city = prefered_city;
        this.prefered_lang = prefered_lang;
        this.is_locked = is_locked;
        this.phone_verifed = phone_verifed;
        this.push_notification_token = push_notification_token;
    }
}

class Cart {
    static build({ id, quantity }) {
        return new Cart(id, quantity);
    }
    constructor(id, quantity) {
        this.id = id;
        this.quantity = quantity;
    }
}


class UserCompany {
    static build({ id, role }) {
        return new UserCompany(id, role);
    }
    constructor(id, role) {
        this.id = id;
        this.role = role;
    }
}

module.exports = {
    Category,
    CategoryTranslation,
    Company,
    CompanyTranslation,
    Product,
    ProductTranslation,
    User,
    Cart,
    UserCompany,
};