const { Like } = require('typeorm');
const { companyRepo, companyTranRepo } = require('../infra/data');
var data = require('../infra/data');


function companyController() {
    const companies = companyRepo();
    const translations = companyTranRepo();

    return Object.freeze({
        getAll,
        getById,
        getFeatured,

        create,
        update,


        getTranslates,
        addTranslation,
        updateTranslation,
        removeTranslation,


        search,
    });

    function search({ query, lang }) {
        return companies.find({
            where: {
                visible: true,
                translations: {
                    title: Like('%' + query + '%'),
                    lang,
                },
            },
            relations: ['translations'],
        }).then(res => {
            res.forEach(v => v.flatTranslation(v.translations, lang));
            return res;
        }).catch(() => []);
    }

    function getAll({ categoryId, lang }) {
        return companies.find({
            where: { visible: true, category: categoryId }
        }).then(res => {
            res.forEach(v => v.flatTranslation(v.translations, lang));
            return res;
        }).catch(() => []);
    }

    function getFeatured({ categoryId, lang }) {
        return companies.find({
            where: { categoryId, featured: true, visible: true, }
        }).then(res => {
            res.forEach(v => v.flatTranslation(v.translations, lang));
            return res;
        }).catch(() => []);
    }

    function getById({ id, lang }) {
        return companies.findOne({ where: { id } })
            .then(res => {
                return res.flatTranslation(res.translations, lang)
            })
            .catch(() => []);
    }

    async function create({
        title, desc, logo, photo, phone, location_lat, location_lng,
        featured, open_minute, close_minute, categoryId, lang, visible
    }) {
        const com = await companies.save({
            logo,
            phone,
            location_lat,
            location_lng,
            featured,
            visible,
            open_minute,
            close_minute,
            category: categoryId,
        });
        await addTranslation({ companyId: com.id, title, photo, desc, lang });
    }

    function update({
        id, visible, logo, phone, location_lat, location_lng,
        featured, open_minute, close_minute, categoryId
    }) {
        return companies.update({ id }, {
            logo,
            phone,
            location_lat,
            location_lng,
            featured,
            visible,
            open_minute,
            close_minute,
            category: categoryId,
        });
    }


    function getTranslates({ companyId }) {
        return translations.find({
            where: { company: companyId },
            relations: ['company']
        });
    }

    function addTranslation({ companyId, title, desc, photo, lang }) {
        return translations.save({
            photo,
            title,
            desc,
            lang,
            company: companyId,
        });
    }

    function updateTranslation({ id, title, desc, photo, lang }) {
        return translations.update({ id }, {
            title,
            photo,
            desc,
            lang
        });
    }

    function removeTranslation({ id }) {
        return translations.remove({ id });
    }
}

module.exports = () => companyController();
