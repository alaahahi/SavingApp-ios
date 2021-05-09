const { productRepo, productTranRepo } = require('../infra/data');


function productController() {
    const products = productRepo();
    const translations = productTranRepo();

    return Object.freeze({
        getAll,
        getFeatured,
        create,
        update,


        getTranslates,
        addTranslation,
        updateTranslation,
        removeTranslation,
    });

    function getAll({ companyId, lang }) {
        return products.find({
            where: { company: companyId, visible: true }
        }).then(res => {
            res.forEach(v => v.flatTranslation(v.translations, lang));
            return res;
        }).catch(() => []);
    }

    function getFeatured({ lang }) {
        return products.find({
            where: { featured: true, visible: true }
        }).then(res => {
            res.forEach(v => v.flatTranslation(v.translations, lang));
            return res;
        }).catch(() => []);
    }

    async function create({
        title,
        desc,
        photo,
        price,
        visible,
        featured,
        discount_price,
        discount_start_data,
        discount_end_data,
        companyId,
        lang
    }) {
        const prod = await products.save({
            photo,
            price,
            visible,
            featured,
            discount_price,
            discount_start_data,
            discount_end_data,
            company: companyId,
        });

        await addTranslation({ productId: prod.id, title, desc, lang })
    }

    function update({
        id,
        photo,
        price,
        visible,
        featured,
        discount_price,
        discount_start_data,
        discount_end_data,
        companyId,
    }) {
        return products.update({ id }, {
            photo,
            price,
            visible,
            featured,
            discount_price,
            discount_start_data,
            discount_end_data,
            company: companyId,
        });
    }


    function getTranslates({ productId }) {
        return translations.find({
            where: { product: productId },
            relations: ['product']
        });
    }

    function addTranslation({ productId, title, desc, lang }) {
        return translations.save({
            title,
            desc,
            lang,
            product: productId,
        });
    }

    function updateTranslation({ id, title, desc, lang }) {
        return translations.update({ id }, {
            title,
            desc,
            lang
        });
    }

    function removeTranslation({ id }) {
        return translations.remove({ id });
    }
}

module.exports = () => productController();