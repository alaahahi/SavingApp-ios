const { categoryRepo, categoryTranRepo } = require("../infra/data");


function categoryController() {
    const categories = categoryRepo();
    const translations = categoryTranRepo();

    return Object.freeze({
        get,
        getAll,
        create,
        update,
        remove,

        getTranslates,
        addTranslation,
        updateTranslation,
        removeTranslation,
    });

    function get({ id, lang }) {
        return categories.findOne({
            where: { visible: true, id, },
        }).then(res => {
            res.flatTranslation(v.translations, lang);
            return res;
        }).catch(() => ({}));
    }

    function getAll({ lang }) {
        return categories.find({
            where: { visible: true },
            order: { order: 'ASC' },
        }).then(res => {
            res.forEach(v => v.flatTranslation(v.translations, lang));
            return res;
        }).catch(() => []);
    }

    async function create({ title, logo, photo, lang, order = 0, visible = true, color }) {
        const cat = await categories.save({
            order,
            visible,
            logo,
            color,
        });

        await addTranslation({ categoryId: cat.id, title, photo, lang });
    }

    async function getTranslates({ categoryId }) {
        return await translations.find({
            where: { category: categoryId },
            relations: ['category']
        });
    }

    async function addTranslation({ categoryId, title, photo, lang }) {
        await translations.save({
            photo,
            title,
            lang,
            category: categoryId,
        });
    }

    async function updateTranslation({ id, title, photo, lang }) {
        await translations.update({ id }, {
            title,
            photo,
            lang
        });
    }

    async function removeTranslation({ id }) {
        await translations.remove({ id });
    }


    async function update({ id, logo, order = 0, visible = true, categ }) {
        await categories.update({ id }, {
            order,
            visible,
            logo
        });
    }

    async function remove({ id }) {
        await categories.remove({ id });
    }
}

module.exports = () => categoryController();